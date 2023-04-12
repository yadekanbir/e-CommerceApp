//
//  FavoritesViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 27.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavoritesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ProductCellDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var db: Firestore!
    var listener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
        fetchDoc()
    }
    
    func fetchDoc(){
        let docRef = db.collection("users").document(UserService.user.id).collection("favorites")
        docRef.getDocuments { (snap, error) in
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
    
    func productFavorited(product: Product) {
        UserService.favoriteSelected(product: product)
        guard let index = products.firstIndex(of: product) else {return}
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row], delegate: self)
            print(products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
