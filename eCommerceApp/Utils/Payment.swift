//
//  Payment.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 20.04.2023.
//

import Foundation

let Payment = _Payment()

final class _Payment {
    
    var cartItems = [Product]()
    let flatFeeCents = 15
    
    var subtotal: Int {
        var amount = 0
        for item in cartItems {
            let pricePennies = Int(item.price * 100)
            amount += pricePennies
        }
        return amount
    }
    
    var total : Int {
        return subtotal + flatFeeCents
    }
}
