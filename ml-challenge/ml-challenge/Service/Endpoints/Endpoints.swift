//
//  Endpoints.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

struct Endpoints {
    static func searchItem(_ item: String, _ offset: Int) -> String {
        return "\(ApiConstants.apiURL)/sites/\(AppConstants.siteId.rawValue)/search?q=\(item)&offset=\(offset)"
    }
    
    static func searchBySeller(_ sellerId: String, _ categoryId: String) -> String {
        return "\(ApiConstants.apiURL)/sites/\(AppConstants.siteId.rawValue)/search?seller_id=\(sellerId)&category=\(categoryId)"
    }
}
