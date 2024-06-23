//
//  UserDefaultsHelper.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

/// A helper class for managing UserDefaults operations.
class UserDefaultsHelper {
    private init () {}
    static let shared = UserDefaultsHelper()
    
    private let defaults = UserDefaults.standard
    
    /// Return a string value from UserDefaults.
    /// - Parameter key: The key to search
    /// - Returns: The string associated
    func getString(forKey key: AppConstants.UserDefaultsKeys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    /// Save a string value to UserDefaults.
    /// - Parameters:
    ///   - value: The string to save
    ///   - key: The key to associated the value
    func saveString(_ value: String, forKey key: AppConstants.UserDefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
        defaults.synchronize()
    }
}
