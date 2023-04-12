//
//  User.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 26.03.2023.
//

import Foundation

struct User {
    var id: String
    var email: String
    var userName: String
    
    init(id: String = "", email: String = "", userName: String = "") {
        self.id = id
        self.email = email
        self.userName = userName
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        userName = data["userName"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any] {
        let data: [String: Any] = [
            "id": user.id,
            "email": user.email,
            "userName": user.userName
        ]
        return data
    }
}
