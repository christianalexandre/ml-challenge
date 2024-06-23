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
}
