//
//  User.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class User: NSObject {
    var firstname: String?
    var surname: String?
    var username: String?
    var uid: String?
    var weight: String?
    var yearOfBirth: String?
    var email: String?
    var gender: String?
    var profileImageURL: String?
    var friends: [User] = []
    
    override init() {}
    
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
    
    
    init(firstname: String, surname: String, gender: String, yearOfBirth: String, weight: String) {
        self.firstname = firstname
        self.surname = surname
        self.gender = gender
        self.yearOfBirth = yearOfBirth
        self.weight = weight
    }
    
    init(dictionary: [String: Any]) {
        
    }
    
    
    // TODO: refactor better way
    func createUserDictionary() -> Dictionary<String, Any> {
        let data: Dictionary<String, Any> = [Constants.User.FIRST_NAME: firstname ?? "",
                                             Constants.User.SURNAME: surname ?? "",
                                             Constants.User.EMAIL: email ?? "",
                                             Constants.User.UID: uid ?? "",
                                             Constants.User.USERNAME: username ?? "",
                                             Constants.User.FRIENDS: friends,
                                             Constants.User.WEIGHT: weight ?? "",
                                             Constants.User.YEAR_BIRTH: yearOfBirth ?? "",
                                             Constants.User.GENDER: gender ?? "",
                                             Constants.User.PROFILE_URL: profileImageURL ?? ""
        ]
        
        return data
    }

    //User data gets update just by attributes in allowed in Profile.Storyboard
    func updateDataBy(user: User) {
        firstname = user.firstname
        surname = user.surname
        weight = user.weight
        gender = user.gender
        yearOfBirth = user.yearOfBirth
    }
    
}
