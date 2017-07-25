//
//  AuthError.swift
//  HearthApp
//
//  Created by Adam Zvada on 16.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

struct AuthError {
    static let USER_NOT_FOUND = "User not found! Does not exist."
    static let WRONG_PASSWORD = "Typed wrong password!"
    static let INVALID_EMAIL = "Invalid email."
    static let EMAIL_ALREADY_USED = "Email has been already used."
    static let PROBLEM_CONNECTING = "Problem with connection to database."
    static let DEFAULT = "Something went wrong."
    static let WEAK_PASSWORD = "Weak password, at least 6 characters."
    
    static let EMAIL_PASSWORD_REQUIRED = "Email and password are requierd."
    static let EMAIL_PASSWORD_TYPE = "Please, fill in your email and password."
}
