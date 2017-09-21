//
//  Constants.swift
//  HearthApp
//
//  Created by Adam Zvada on 16.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

struct Constants {
    
    static let DB_URL = "https://hearthapp-85f80.firebaseio.com/"
    static let STORAGE_URL = "gs://hearthapp-85f80.appspot.com"
    
    static let USER = "user"
    static let FRIENDS = "friend"
    static let PROFILE = "profile"
    static let HEART = "heart"
    
    struct DatabaseEntities {
        static let USER = "user"
        static let FRIENDS = "friend"
        static let PROFILE = "profile"
        static let HEART = "heart"
    }
    
    struct User {
        static let FIRST_NAME = "firstname"
        static let SURNAME = "surname"
        static let USERNAME = "username"
        static let GENDER = "gender"
        static let UID = "uid"
        static let EMAIL = "email"
        static let FRIENDS = "friends"
        static let WEIGHT = "weight"
        static let YEAR_BIRTH = "yearOfBirth"
        static let PROFILE_URL = "profileImageURL"
    }
    
    struct Heart {
        static let TIMESTAMP = "timestamp"
        static let RATE = "rate"
    }
    
    struct Controllers {
        static let LOGIN = "LoginViewController"
        static let SIGN_UP = "SignUpViewController"
        static let PROFILE = "ProfileViewController"
        static let SELECT_FRIENDS = "SelectFriendsViewController"
        static let ADD_FRIENDS = "AddFriendViewController"
        static let GRAPH = "GraphViewController"
    }
    
    struct Storyboards {
        static let LOGIN = "SignIn"
        static let SIGN_UP = "SignUp"
        static let GRAPH = "Main"
        static let PROFILE = "Profile"
        static let SELECT_FRIENDS = "SelectFriends"
        static let ADD_FRIENDS = "AddFriends"
    }
    
    struct UserDef {
        static let FIRST_LAUNCH = "firstLauch"

    }
    
}
