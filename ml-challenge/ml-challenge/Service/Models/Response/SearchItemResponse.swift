//
//  SearchItemResponse.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

struct SearchItemResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query
        case paging
        case results
    }
    
    let siteId: String
    let query: String?
    let paging: PaginationSearchItemResponse
    let results: [SearchItem]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        siteId = try container.decode(String.self, forKey: .siteId)
        query = try container.decodeIfPresent(String.self, forKey: .query)
        paging = try container.decode(PaginationSearchItemResponse.self, forKey: .paging)
        results = try container.decode([SearchItem].self, forKey: .results)
    }
}
