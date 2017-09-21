//
//  DBProvider.swift
//  HearthApp
//
//  Created by Adam Zvada on 16.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

/*
 *  Database Model
 *
 *  +USER
 *      +UID
 *          -username
 *          -firstname
 *          -surname
 *          -weight
 *          -year of birth
 *          +FRIENDS
 *              +UID
 *                  -isFriends
 *  +HEART
 *      +UID
 *          +TIMESTAMP
 *              -rate
 *
 */
class DBProvider {
    
    static let sharedInstance = DBProvider()
    
    
    var dbRef : DatabaseReference {
        return Database.database().reference(fromURL: Constants.DB_URL)
    }
    
    var userRef : DatabaseReference {
        return dbRef.child(Constants.USER)
    }
    
    var storageRef : StorageReference {
        return Storage.storage().reference(forURL: Constants.STORAGE_URL)
    }
    
    func profileRef(UID: String) -> DatabaseReference {
        return userRef.child(UID)
    }
    
    func friendsOfUser(UID: String) -> DatabaseReference {
        return self.profileRef(UID: UID).child(Constants.User.FRIENDS)
    }
    
    func heartRef() -> DatabaseReference {
        return dbRef.child(Constants.HEART)
    }
    
    func heartOfUserRef(UID: String) -> DatabaseReference {
        return heartRef().child(UID)
    }
}
