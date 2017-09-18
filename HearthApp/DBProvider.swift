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
 *  DBProvider is singleton
 */
class DBProvider {
    
    static let sharedInstance = DBProvider()
    
    
    //Returns the link to top db
    var dbRef : FIRDatabaseReference {
        return FIRDatabase.database().reference(fromURL: Constants.DB_URL)
    }
    
    var userRef : FIRDatabaseReference {
        return dbRef.child(Constants.USER)
    }
    
    var storageRef : FIRStorageReference {
        return FIRStorage.storage().reference(forURL: Constants.STORAGE_URL)
    }
    
    func profileRef(UID: String) -> FIRDatabaseReference {
        return userRef.child(UID)
    }
    
    func friendsOfUser(UID: String) -> FIRDatabaseReference {
        return self.profileRef(UID: UID).child(Constants.FRIENDS)
    }
    
    func heartOfUserRef(UID: String) -> FIRDatabaseReference {
        return self.profileRef(UID: UID).child(Constants.HEART)
    }
}
