//
//  AuthProvider.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseAuth

/*
 * Singleton
 */
class AuthProvider {
    
    private static let authInstance = AuthProvider()
    
    static var getInstance : AuthProvider {
        return authInstance;
    }
    
    
    func login(email : String, password : String, loginHandler: ((_ msg : String?) -> Void)?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                loginHandler!(nil)
            } else {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
        })
        
    }
    
    
    func signup(email : String, username: String, password : String, loginHandler: ((_ msg : String?) -> Void)?) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                guard user != nil else {
                    print("------------ USER ERROR, not probable ------------")
                    return
                }
                
                loginHandler!(nil)
                
                
                let userEntity = User(email: email, username: username, UID: user!.uid)
                
                UserHandler.sharedInstance.addUser(user: userEntity)
                
                self.login(email: email, password: password, loginHandler: loginHandler)
                
            } else {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
        })
        
    }
    
    
    private func handleErrors(err : NSError, loginHandler : ((_ msg : String?) -> Void)?) {
        if let errCode = FIRAuthErrorCode(rawValue: err.code) {
            switch errCode {
                
            case FIRAuthErrorCode.errorCodeUserNotFound:
                loginHandler!(AuthError.USER_NOT_FOUND)
                break;
            case FIRAuthErrorCode.errorCodeWrongPassword:
                loginHandler!(AuthError.WRONG_PASSWORD)
                break;
            case FIRAuthErrorCode.errorCodeInvalidEmail:
                loginHandler!(AuthError.INVALID_EMAIL)
                break;
            case FIRAuthErrorCode.errorCodeEmailAlreadyInUse:
                loginHandler!(AuthError.EMAIL_ALREADY_USED)
                break;
            case FIRAuthErrorCode.errorCodeNetworkError:
                loginHandler!(AuthError.PROBLEM_CONNECTING)
                break;
            case FIRAuthErrorCode.errorCodeWeakPassword:
                loginHandler!(AuthError.WEAK_PASSWORD);
                break;
            default:
                loginHandler!(AuthError.DEFAULT)
            }
        }
    }
    

    
}
