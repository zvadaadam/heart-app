//
//  UserHandler.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

protocol FetchUsersData: class {
    func recivedUserData(user: User)
    func recivedUserDataWithFriends(user: User)
}

class UserHandler {
    
    static let sharedInstance = UserHandler()
    
    weak var delegate: FetchUsersData?
    
    func addUser(user: User) {
        
        let data = createDictionaryWith(user: user)
        
        DBProvider.sharedInstance.userRef.child(user.uid!).setValue(data)
    }
    
    func getUser(UID: String) {
        DBProvider.sharedInstance.profileRef(UID: UID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let user = snapshot.value as? User {
                self.delegate?.recivedUserData(user: user)
            }
        })
    }
    
    func getUserWithFriends(UID: String) {
        
    }
    
    func createDictionaryWith(user: User) -> Dictionary<String, Any> {
        
        let data: Dictionary<String, Any> = [Constants.User.FIRST_NAME: user.firstname ?? "", Constants.User.SURNAME: user.surname ?? "",   Constants.User.EMAIL: user.email ?? "", Constants.User.UID: user.uid ?? "", Constants.User.USERNAME: user.username ?? "",
            Constants.User.FRIENDS: user.friends]
        
        return data
    }
    
}
