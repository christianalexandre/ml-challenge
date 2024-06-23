//
//  AppConstants.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

struct AppConstants {
    static var siteId: SiteId {
        return Locale.current.language.languageCode?.identifier.contains("es") == true ? .mla : .mlb
    }
    
    enum UserDefaultsKeys: String {
        case lastSearchCategory
    }
}
