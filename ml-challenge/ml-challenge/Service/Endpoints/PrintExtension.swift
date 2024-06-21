//
//  PrintExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation

public func print(tag: String = "ML_CHALLENGE_DEBUG", _ object: Any) {
    #if DEBUG
    Swift.print("\(tag): \(object)")
    #endif
}
