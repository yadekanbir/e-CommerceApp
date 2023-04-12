//
//  ViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        guard let email = emailTextField.text , email.isNotEmpty,
              let password = passwordTextField.text , password.isNotEmpty else {return}
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error!.localizedDescription ?? "Error!")
                } else {
                    UserService.getCurrentUser()
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        } else{
            self.makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
    }
    
    @IBAction func joinUsClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        }
    
}

