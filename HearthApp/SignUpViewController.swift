//
//  SignUpViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    @IBOutlet weak var usernameField: HoshiTextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardOnTap()
        
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
        setTextFieldsTargetNotEmpty()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showSignIn(vc: self)
    }

    func signupTapped() {
        if let username = usernameField.text, let password = passwordField.text, let email = emailField.text {
            if username != "" && password != "" && email != "" {
                AuthProvider.sharedInstance.signup(email: email, username: username, password: password, loginHandler: { (msg) in
                    if msg != nil {
                        self.alertUser(title: "Sign Up", msg: msg)
                    } else {
                        print("SIGN UP SUCSESS")
                        
                        PresentStoryboard.sharedInstance.showProfile(vc: self)
                    }
                })
            }
        }
    }
    
    private func setTextFieldsTargetNotEmpty() {
        signupButton.disable()
        
        usernameField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        
    }
    
    @objc private func textFieldsIsNotEmpty() {
        guard let username = usernameField.text, !username.isEmpty, username != usernameField.placeholder,
            let password = passwordField.text, !password.isEmpty, password != passwordField.placeholder,
            let email = emailField.text, !email.isEmpty, email != emailField.placeholder else {
                return
        }
        
        signupButton.enable()
    }
    
    private func alertUser(title : String, msg : String?) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func firstLaunchParam() {
        UserDefaults.standard.set(true, forKey: Constants.UserDef.FIRST_LAUNCH)
    }
}
