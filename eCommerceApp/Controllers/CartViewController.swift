//
//  CartViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartViewCellDelegate {
    
      
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var cartItems = [Product]()
    var db: Firestore!
    var listener: ListenerRegistration!
    var product : Product!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.CartViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.CartViewCell)
        fetcDocument()
    }
    
    func fetcDocument() {
        let documentRef = db.collection("users").document(UserService.user.id).collection("cart")
        documentRef.getDocuments { snap, error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                self.products.removeAll(keepingCapacity: false)
                guard let documents = snap?.documents else {return}
                for document in documents {
                    let data = document.data()
                    let newProduct = Product.init(data: data)
                    self.products.append(newProduct)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func addToCartClicked(product: Product) {
        UserService.addToCartSelected(product: product)
        guard let index = products.firstIndex(of: product) else {return}
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CartViewCell, for: indexPath) as? CartViewCell {
            cell.configure(product: products[indexPath.row], delegate: self)
            print(products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func removeToCartSelected(product : Product){
        let cartItemsRef = Firestore.firestore().collection("users").document(UserService.user.id).collection("cart")
        if cartItems.contains(product){
            cartItems.removeAll{ $0 == product }
            cartItemsRef.document(product.id).delete()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
