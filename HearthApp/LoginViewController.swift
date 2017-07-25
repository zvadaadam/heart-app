//
//  LoginViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func signupTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.present(VC, animated: true, completion: nil)

    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        
        if username != "" && password != "" {
            AuthProvider.getInstance.login(email: username!, password: password!, loginHandler: { (msg) in
                if msg != nil {
                    self.alertUser(title: "Login", msg: msg)
                } else {
                    print("LOGIN SUCSESS")

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
