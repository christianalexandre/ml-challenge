//
//  SiteId.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

enum SiteId: String {
    case mla = "MLA"
    case mlb = "MLB"
    
    var pricePrefix: String {
        switch self {
        case .mla:
            return "$"
        case .mlb:
            return "R$"
        }
    }
}
