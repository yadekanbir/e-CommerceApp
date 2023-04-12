//
//  Firebase+Utils.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 18.03.2023.
//
import FirebaseCore
import FirebaseFirestore

extension Firestore {
    var products : CollectionReference {
        return collection("Products")
    }
}
