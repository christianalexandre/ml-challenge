//
//  SearchItemRepository.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import RxSwift

/// Repository responsible for searching items
class SearchItemRepository {
    /// Searches for items by name and offset
    ///
    /// - Parameters:
    ///   - item: The search term to look for items.
    ///   - offset: The offset for pagination.
    /// - Returns: A Single emitting the search results.
    func searchItem(_ item: String, _ offset: Int) -> Single<SearchItemResponse> {
        let endpoint = Endpoints.searchItem(item, offset)
        return BaseRepository.shared.createSingleRequest(
            method: .get,
            url: endpoint
        )
    }
    
    /// Searches for items by a specific seller and specific category.
    ///
    /// - Parameters:
    ///   - sellerId: The ID of the seller whose items are to be searched.
    ///   - category: The category of items to search within.
    /// - Returns: A Single emitting the search results.
    func searchBySellerId(_ sellerId: String, _ category: String) -> Single<SearchItemResponse> {
        let endpoint = Endpoints.searchBySeller(sellerId, category)
        return BaseRepository.shared.createSingleRequest(
            method: .get,
            url: endpoint
        )
    }
    
    /// Searches for items by a specific category.
    ///
    /// - Parameters:
    ///   - category: The category of items to search within.
    /// - Returns: A Single emitting the search results.
    func searchByCategory(_ category: String, _ offset: Int) -> Single<SearchItemResponse> {
        let endpoint = Endpoints.searchByCategory(category, offset)
        return BaseRepository.shared.createSingleRequest(
            method: .get,
            url: endpoint
        )
    }
}
