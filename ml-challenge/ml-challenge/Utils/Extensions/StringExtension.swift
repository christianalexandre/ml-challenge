//
//  StringExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 22/06/24.
//

import Foundation
import UIKit

extension String {
    func strikeThroughText() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
