//
//  User.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

struct User {
    var firstname: String?
    var surname: String?
    var username: String?
    var uid: String?
    var email: String?
    var friends: [User] = []
    
    init(email: String, username: String, UID: String) {
        self.email = email
        self.username = username
        self.uid = UID
    }
    
    init(firstname: String, surname: String, UID: String, friends: [User]) {
        self.firstname = firstname
        self.surname = surname
        self.uid = UID
        self.friends = friends
    }
    
}
