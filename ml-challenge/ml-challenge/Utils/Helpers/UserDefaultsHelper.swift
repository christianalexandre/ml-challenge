//
//  UserDefaultsHelper.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

class UserDefaultsHelper {
    private init () {}
    static let shared = UserDefaultsHelper()
    
    private let defaults = UserDefaults.standard
    
    func getString(forKey key: AppConstants.UserDefaultsKeys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    func saveString(_ value: String, forKey key: AppConstants.UserDefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
        defaults.synchronize()
    }
}
