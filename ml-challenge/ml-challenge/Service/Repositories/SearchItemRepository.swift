//
//  SearchItemRepository.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import RxSwift

class SearchItemRepository {
    func searchItem(_ item: String, _ offset: Int) -> Single<SearchItemResponse> {
        let endpoint = Endpoints.searchItem(item, offset)
        return BaseRepository.shared.createSingleRequest(
            method: .get,
            url: endpoint
        )
    }
}
