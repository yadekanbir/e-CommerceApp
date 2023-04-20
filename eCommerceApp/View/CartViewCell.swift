//
//  CartViewCell.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 12.04.2023.
//

import UIKit
import Kingfisher
import FirebaseFirestore

protocol CartViewCellDelegate : class {
    func addToCartClicked(product: Product)
    func removeItemFromCart (product: Product)
}

class CartViewCell: UITableViewCell {
   
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var prodcutPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var removeItem: UIButton!
    
    var delegate: CartViewCellDelegate?
    var product: Product?
    var cartItems = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure (product: Product, delegate: CartViewCellDelegate){
        self.product = product
        self.delegate = delegate
        
        productName.text = product.name
        
        if let url = URL(string: product.imageUrl){
            let placeholder = UIImage(named: "product")
            productImage.kf.setImage(with: url, placeholder: placeholder)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            prodcutPrice.text = price
        }
        
        stepper.value = Double(product.stock)
        quantityLabel.text = Int(stepper.value).description
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        self.product?.stock = Int(stepper.value)
        guard let product = self.product else {return}
        let stepper = sender as! UIStepper
        quantityLabel.text = Int(stepper.value).description
        if stepper.value == 0 {
            UserService.removeFromCart(product: product)
            stepper.isEnabled = false
        }
    }
    
    @IBAction func removeItemFromCart(_ sender: Any) {
        delegate?.removeItemFromCart(product: product!)
    }
}
