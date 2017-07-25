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
    
    private static let instance = DBProvider()
    
    static var getInstance : DBProvider {
        return instance
    }
    
    //Returns the link to top db
    var dbRef : FIRDatabaseReference {
        //return FIRDatabase.database().reference();
        return FIRDatabase.database().reference(fromURL: "https://hearthapp-85f80.firebaseio.com/")
    }
    
//    var userRef : FIRDatabaseReference {
//        return dbRef.child(Constants.USER)
//    }
//    
//    var storageRef : FIRStorageReference {
//        return FIRStorage.storage().reference(forURL: Constants.STORAGE_URL)
//    }
//    
//    func getUsersFriendsRef(UID : String) -> FIRDatabaseReference {
//        return userRef.child(UID).child(Constants.FRIENDS)
//    }
//    
//    func getUsersHeartRef(UID : String) -> FIRDatabaseReference {
//        return userRef.child(UID).child(Constants.HEART)
//    }
//    
}
