//
//  SearchItem.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

struct SearchItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case siteId = "site_id"
        case title
        case price
    }
    
    let id: String
    let siteId: String
    let title: String
    let price: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        siteId = try container.decode(String.self, forKey: .siteId)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Double.self, forKey: .price)
    }
}

