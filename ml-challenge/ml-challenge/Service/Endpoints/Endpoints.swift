//
//  Endpoints.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

struct Endpoints {
    static func searchItem(_ item: String) -> String {
        return "\(ApiConstants.apiURL)/sites/MLB/search?q=\(item)"
    }
}
