//
//  NSErrorExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

extension NSError {
    static func thowError(message: String) -> NSError {
        return NSError.init(domain: "ml-challenge", code: -1, userInfo: ["message": message])
    }
}
