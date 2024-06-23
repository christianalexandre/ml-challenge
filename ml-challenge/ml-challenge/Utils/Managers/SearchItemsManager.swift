//
//  SearchItemsManager.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation
import RxSwift
import RxAlamofire

class SearchItemsManager {
    private init() {}
    static let shared = SearchItemsManager()
    
    private let disposeBag = DisposeBag()
    private let searchRepository = SearchItemRepository()
    private var lastSearchByName = ""
}

extension SearchItemsManager {
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
