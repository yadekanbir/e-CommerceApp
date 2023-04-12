//
//  SignUpViewController.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange (_ textField : UITextField) {
        guard let passTxt = passwordTextField.text else {return}
        
        if textField == confirmPasswordTextField{
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPasswordTextField.text = ""
            }
        }
        
        if passwordTextField.text == confirmPasswordTextField.text {
            passCheckImg.image = UIImage(systemName: AppImages.Checkmark)
            confirmPassCheckImg.image = UIImage(systemName: AppImages.Checkmark)
        } else {
            passCheckImg.image = UIImage(systemName: AppImages.Multiply)
            confirmPassCheckImg.image = UIImage(systemName: AppImages.Multiply)
        }
    }
    
    @IBAction func joinUsClicked(_ sender: Any) {
        
        guard let email = emailTextField.text , email.isNotEmpty,
              let username = nameTextField.text, username.isNotEmpty,
              let password = passwordTextField.text , password.isNotEmpty else {return}
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error!.localizedDescription ?? "Error!")
                } else {
                    guard let firUser = result?.user else {return}
                    let pandUser = User.init(id: firUser.uid, email: email, userName: username)
                    self.createFirestoreUser(user: pandUser)
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
         }
    }
   
    func createFirestoreUser(user: User) {
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        let data = User.modelToData(user: user)
        newUserRef.setData(data) { (error) in
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription ?? "Error!")
            } else {
                self.performSegue(withIdentifier: "toHomeVC", sender: nil)
            }
        }
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
