//
//  SignUpViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        
        if username != "" && password != "" {
            AuthProvider.getInstance.signup(email: username!, password: password!, loginHandler: { (msg) in
                if msg != nil {
                    self.alertUser(title: "Sign Up", msg: msg)
                } else {
                    print("SIGN UP SUCSESS")
                    
                    self.performSegue(withIdentifier: ViewConstants.FRIEND_SEGUE, sender: nil)
                }
            })
        } else {
            
        }
    }
    
    private func alertUser(title : String, msg : String?) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
