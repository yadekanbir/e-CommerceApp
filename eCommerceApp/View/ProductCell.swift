//
//  ProductCell.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 26.03.2023.
//

import UIKit
import Kingfisher

protocol ProductCellDelegate: class {
    func productFavorited(product : Product)
    func addToCartClicked(product: Product)
}

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    weak var delegate : ProductCellDelegate?
    private var product : Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(product: Product, delegate: ProductCellDelegate){
        self.product = product
        self.delegate = delegate
        productNameLabel.text = product.name
        if let url = URL(string: product.imageUrl){
            let placeholder = UIImage(named: "product")
            productImage.kf.setImage(with: url, placeholder: placeholder)
        }
        productPriceLabel.text = product.price
        
        if UserService.favorites.contains(product) {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        delegate?.addToCartClicked(product: product)
    }

    @IBAction func favButtonClicked(_ sender: Any) {
        delegate?.productFavorited(product: product)
    }
}
