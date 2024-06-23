//
//  Attributes.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

struct Attributes: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case valueName = "value_name"
    }
    
    let name: String?
    let valueName: String?
}

extension Array where Element == Attributes {
    func toDictionary() -> [String: String] {
        var dictionary = [String: String]()
        for attribute in self {
            guard let name = attribute.name,
                  let value = attribute.valueName
            else { break }
            dictionary[name] = value
        }
        return dictionary
    }
}
