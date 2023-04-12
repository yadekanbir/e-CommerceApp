//
//  ProfileViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserService.logoutUser()
            performSegue(withIdentifier: "toSignInVC" , sender: nil)
        } catch {
            print("Error")
        }
    }
}

