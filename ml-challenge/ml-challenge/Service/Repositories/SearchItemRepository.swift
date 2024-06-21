//
//  SearchItemRepository.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import RxSwift

class SearchItemRepository {
    func searchItem(_ item: String) -> Single<SearchItemResponse> {
        let endpoint = Endpoints.searchItem(item)
        return BaseRepository.shared.createSingleRequest(
            method: .get,
            url: endpoint
        )
    }
}
