//
//  LoginViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardOnTap()
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        setTextFieldsTargetNotEmpty()
    }
    
    
    
    @IBAction func signupTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showSignUp(vc: self)
    }
    
    func loginTapped() {
        if let email = emailField.text, let password = passwordField.text {
            if email != "" && password != "" {
                AuthProvider.sharedInstance.login(email: email, password: password, loginHandler: { (msg) in
                    if msg != nil {
                        self.alertUser(title: "Login", msg: msg)
                    } else {
                        print("LOGIN SUCSESS")
                        
                        HeartHandler.sharedInstance.storeHeartRateInTime(fromTimestamp:  (Calendar.current.date(byAdding: .day, value: -1, to: Date())?.timeIntervalSince1970)!, toTimestamp: Date().timeIntervalSince1970)
                        
                        //TODO
                        PresentStoryboard.sharedInstance.showProfile(vc: self)
                        //PresentStoryboard.sharedInstance.showGraph(vc: self)
                    }
                })
            } else {
            
            }
        }
    }
    
    private func alertUser(title : String, msg : String?) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func setTextFieldsTargetNotEmpty() {
        loginButton.disable()
        
        emailField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc private func textFieldsIsNotEmpty() {
        guard let email = emailField.text, !email.isEmpty, email != emailField.placeholder,
            let password = passwordField.text, !password.isEmpty, password != passwordField.placeholder else {
                return
        }
        
        loginButton.enable()
    }
}
