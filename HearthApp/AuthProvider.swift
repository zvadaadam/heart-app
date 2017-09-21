//
//  AuthProvider.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthProvider {
    
    static let sharedInstance = AuthProvider()
    
    func login(email : String, password : String, loginHandler: ((_ msg : String?) -> Void)?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                loginHandler!(nil)
                UserHandler.sharedInstance.addUsernameToDefaults()
            } else {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
        })
        
    }
    
    
    func signup(email : String, username: String, password : String, loginHandler: ((_ msg : String?) -> Void)?) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                guard user != nil else {
                    print("------------ USER ERROR, not probable ------------")
                    return
                }
                
                loginHandler!(nil)
                
                
                let userEntity = User(email: email, username: username, UID: user!.uid)
                
                UserHandler.sharedInstance.addUser(user: userEntity)
                
                self.login(email: email, password: password, loginHandler: loginHandler)
                
                UserDefaults.standard.set(username, forKey: Constants.User.USERNAME)
            } else {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
        })
        
    }
    
    
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false
            }
        }
        return true
    }
    
    func currentUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    private func handleErrors(err : NSError, loginHandler : ((_ msg : String?) -> Void)?) {
        if let errCode = AuthErrorCode(rawValue: err.code) {
            switch errCode {
                
            case AuthErrorCode.userNotFound:
                loginHandler!(AuthError.USER_NOT_FOUND)
                break;
            case AuthErrorCode.wrongPassword:
                loginHandler!(AuthError.WRONG_PASSWORD)
                break;
            case AuthErrorCode.invalidEmail:
                loginHandler!(AuthError.INVALID_EMAIL)
                break;
            case AuthErrorCode.emailAlreadyInUse:
                loginHandler!(AuthError.EMAIL_ALREADY_USED)
                break;
            case AuthErrorCode.networkError:
                loginHandler!(AuthError.PROBLEM_CONNECTING)
                break;
            case AuthErrorCode.weakPassword:
                loginHandler!(AuthError.WEAK_PASSWORD);
                break;
            default:
                loginHandler!(AuthError.DEFAULT)
            }
        }
    }
    

    
}
