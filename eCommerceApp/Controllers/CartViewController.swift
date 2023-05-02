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
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
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
        totalLabel.text = "Total: \(Payment.total.penniesToFormattedCurrency())"
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
    
    func removeItemFromCart (product: Product){
        UserService.removeFromCart( product: product)
        guard let index = products.firstIndex(of: product) else {return}
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @IBAction func orderButtonClicked(_ sender: Any) {
        makeAlert(titleInput: "You are about to order!", messageInput: "You can place an order or return to the order screen." )
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let action1 = UIAlertAction(title: "Keep Shopping!", style: UIAlertAction.Style.default, handler: nil)
        let action2 = UIAlertAction(title: "Buy Now!", style: UIAlertAction.Style.default) { [self] (action:UIAlertAction) in
            self.performSegue(withIdentifier: "toLastScreen", sender: nil)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
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
}
