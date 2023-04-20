//
//  OrderConfirmedVC.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 20.04.2023.
//

import UIKit

class OrderConfirmedVC: UIViewController {
    
    @IBOutlet weak var keepShoppingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keepShoppingButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHomeScreenVC", sender: nil)
    }
}
