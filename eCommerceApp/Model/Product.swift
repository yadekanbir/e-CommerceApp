//
//  Product.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 17.03.2023.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id: String
    var price: String
    var description: String
    var imageUrl: String
    var timeStamp: Timestamp
    var stock: Int
    
    init (data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.price = data["price"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.stock = data["stock"] as? Int ?? 0
    }
   
    static func modelToData(product: Product) -> [String: Any] {
        let data : [String: Any] = [
            "name" : product.name,
            "id" : product.id,
            "price" : product.price,
            "productDescription" : product.description,
            "imageUrl" : product.imageUrl,
            "timeStamp" : product.timeStamp,
            "stock" : product.stock
        ]
        return data
    }
}

extension Product : Equatable {
    static func == (lhs: Product , rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
