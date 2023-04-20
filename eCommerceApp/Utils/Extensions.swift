//
//  Extensions.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import Foundation
import UIKit

extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension Int {
    func penniesToFormattedCurrency() -> String {
        let dollars = Double(self)/100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let dollarString = formatter.string(from: dollars as NSNumber) {
            return dollarString
        }
        return "$100.00"
    }
}
