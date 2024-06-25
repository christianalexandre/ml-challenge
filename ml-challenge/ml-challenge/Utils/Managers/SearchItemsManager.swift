//
//  SearchItemsManager.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation
import RxSwift
import RxAlamofire

/// A singleton class responsible for managing search items.
class SearchItemsManager {
    private init() {}
    static var shared = SearchItemsManager()
    
    private let disposeBag = DisposeBag()
    private var searchRepository = SearchItemRepository()
    private var lastSearchByName = ""
}

extension SearchItemsManager {
    /// Fetch items by name and offset
    /// - Parameters:
    ///   - itemName: The item to search. If nil, the last searched name will be used
    ///   - offset: The offset to pagination
    /// - Returns: A Single emitting an array of "Search Item" or error
    func getItemsByName(_ itemName: String?, _ offset: Int) -> Single<[SearchItem]> {
        let itemToSearch = itemName ?? lastSearchByName
        return searchRepository.searchItem(itemToSearch, offset)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(ConcurrentMainScheduler.instance)
            .do(onSuccess: { response in
                self.lastSearchByName = itemToSearch
                UserDefaultsHelper.shared.saveString(response.results.first?.categoryId ?? "", forKey: .lastSearchCategory)
            })
            .flatMap { searchItemResponse -> Single<[SearchItem]> in
                if offset > 1000 {
                    return Single.error(SearchError.offsetError)
                }
                if searchItemResponse.results.isEmpty {
                    return Single.error(SearchError.noResults)
                }
                return Single.just(searchItemResponse.results)
            }
    }
    
    /// Fetch items by seller id
    /// - Parameters:
    ///   - sellerId: The ID of the seller
    ///   - category: The category to filter
    /// - Returns: A Single emitting an array of "Search Item" or error
    func searchBySellerId(_ sellerId: String, _ category: String) -> Single<[SearchItem]> {
        return searchRepository.searchBySellerId(sellerId, category)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(ConcurrentMainScheduler.instance)
            .flatMap { searchItemResponse -> Single<[SearchItem]> in
                if searchItemResponse.results.isEmpty {
                    return Single.error(SearchError.noResults)
                }
                return Single.just(searchItemResponse.results)
            }
    }
    
    /// Download the data image from url
    /// - Parameter urlString: The url string of the image
    /// - Returns: A Single emitting the image data
    func downloadThumnail(from urlString: String?) -> Single<Data> {
        return Single.create { single in
            guard let urlString,
                  let url = URL(string: urlString) else {
                single(.error(SearchError.imageDownloadError))
                return Disposables.create()
            }
            
            RxAlamofire.requestData(.get, url)
                .subscribe(onNext: {( _, data) in
                    single(.success(data))
                }, onError: { error in
                    single(.error(SearchError.imageDownloadError))
                }).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}

extension SearchItemsManager {
    /// Only used by tests
    func replaceRepository(with repository: SearchItemRepository) {
        self.searchRepository = repository
    }
}
