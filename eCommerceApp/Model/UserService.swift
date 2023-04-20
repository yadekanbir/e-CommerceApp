//
//  UserService.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 27.03.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

let UserService = _UserService()

final class _UserService {
    var user = User()
    var favorites = [Product]()
    var cartItems = [Product]()
    var auth = Auth.auth()
    var db = Firestore.firestore()
    var userListener : ListenerRegistration? = nil
    var favListener : ListenerRegistration? = nil
    var cartListener : ListenerRegistration? = nil
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else {return}
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ snap, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print(self.user)
        })
        
        let favRef = userRef.collection("favorites")
        favListener = favRef.addSnapshotListener({ snap, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            snap?.documents.forEach({ document in
                let favorite = Product.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
        
        let cartRef = userRef.collection("cart")
        cartListener = cartRef.addSnapshotListener({ snap, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            snap?.documents.forEach({ document in
                let cart = Product.init(data: document.data())
                self.cartItems.append(cart)
                
            })
        })
    }
    
    func favoriteSelected(product: Product){
        let favsRef = Firestore.firestore().collection("users").document(user.id).collection("favorites")
        if favorites.contains(product){
            favorites.removeAll{ $0 == product }
            favsRef.document(product.id).delete()
        } else {
            favorites.append(product)
            let data = Product.modelToData(product: product)
            favsRef.document(product.id).setData(data)
        }
    }
    
    func addToCartSelected(product : Product){
        let cartItemsRef = Firestore.firestore().collection("users").document(user.id).collection("cart")
            cartItems.append(product)
            let data = Product.modelToData(product: product)
            cartItemsRef.document(product.id).setData(data)
        }
    
    func removeFromCart(product: Product) {
        let cartItemsRef = Firestore.firestore().collection("users").document(user.id).collection("cart")
        if cartItems.contains(product){
            cartItems.removeAll{ $0 == product }
            cartItemsRef.document(product.id).delete()
        }
    }

    func checkIfItemIsAlreadyFavorite(with id : String) -> Bool {
        for item in favorites {
            if item.id == id {
                return true
            }
        }
        return false
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favListener?.remove()
        favListener = nil
        favorites.removeAll()
    }
}


