//
//  DoubleExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

extension Double {
    func formattedString(decimalPlaces: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
