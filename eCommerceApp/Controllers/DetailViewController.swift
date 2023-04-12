//
//  DetailViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 24.03.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTitle.text = product.name
        productPrice.text = product.price
        productDesc.text = product.description
        
        if let url = URL(string: product.imageUrl){
            productImage.kf.setImage(with: url)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func dismissProduct(){
        dismiss(animated: true)
    }
    
    @IBAction func addCartClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func keepShoppingClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

