//
//  PaginationSearchItemResponse.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

struct PaginationSearchItemResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case total
        case offset
        case limit
        case primaryResults = "primary_results"
    }
    
    let total: Int
    let offset: Int
    let limit: Int
    let primaryResults: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        total = try container.decode(Int.self, forKey: .total)
        offset = try container.decode(Int.self, forKey: .offset)
        limit = try container.decode(Int.self, forKey: .limit)
        primaryResults = try container.decode(Int.self, forKey: .primaryResults)
    }
}
