//
//  UserHandler.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol FetchUsersData: class {
    func recivedAllUsers(users: [User])
    func recivedUserData(user: User)
    func recivedUserDataWithFriends(user: User)
}

//TODO : Add Dependecy Injection
class UserHandler {

    static let sharedInstance = UserHandler()
    
    //TODO : CHANGE TO CONTAINER
    var authProvider: AuthProvider = AuthProvider.sharedInstance
    
    //TODO : CHANGE TO CONTAINER
    var dbProvider: DBProvider = DBProvider.sharedInstance
    
    weak var delegate: FetchUsersData?
    
    func addUser(user: User) {
        
        //let data = createDictionaryWith(user: user)
        let data = user.createUserDictionary()
        
        //DBProvider.sharedInstance.userRef.child(user.uid!).setValue(data)
        dbProvider.profileRef(UID: user.uid!).setValue(data)
    }
    
    func addFriendToUser(UID: String, FID: String) {
        dbProvider.friendsOfUser(UID: UID).child(FID)
    }
    
    func getUsers(completion: @escaping ([User]) -> Void) {
        dbProvider.userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            
            var users: [User] = []
            
            if let dictionary = snapshot.value as? [String : Any] {
                for (_, value) in dictionary {
                    if let friendsData = value as? [String : Any] {
                        let user = User()
                        user.setValuesForKeys(friendsData)
                        users.append(user)
                    }
                }
            }
            completion(users)
        })
    }
    
    func getAllUsers() {
        dbProvider.userRef.observeSingleEvent(of: .value, with: { (snapshot) in

            print(snapshot)
            
            if let dictionary = snapshot.value as? [String : Any] {
                
            }
        })
    }
    
    func getUser(UID: String) {
        DBProvider.sharedInstance.profileRef(UID: UID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String : Any] {
                print("===FOO===")
                print(dictionary)
            }
            
            if let user = snapshot.value as? User {
                self.delegate?.recivedUserData(user: user)
            }
            
            
        })
    }
    
//    func getCurrentUser() -> User? {
//        var currentUser: User?
//        
//        dbProvider.profileRef(UID: authProvider.currentUID()!).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String : Any] {
//                currentUser = User()
//                currentUser!.setValuesForKeys(dictionary)
//            }
//        })
//        
//        return currentUser
//    }
    
    func updateCurrentUser(user: User) {
        
        dbProvider.profileRef(UID: authProvider.currentUID()!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let currentUser = User()
                currentUser.setValuesForKeys(dictionary)
                
                currentUser.updateDataBy(user: user)
                snapshot.ref.updateChildValues(currentUser.createUserDictionary())
            }
        })
    }
    
    func getUserWithFriends(UID: String) {
        dbProvider.friendsOfUser(UID: UID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
        })
    }
    
    func addUsernameToDefaults() {
        dbProvider.profileRef(UID: authProvider.currentUID()!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                UserDefaults.standard.set(dictionary[Constants.User.USERNAME], forKey: Constants.User.USERNAME)
            }
        })
    }
    
//    func createDictionaryWith(user: User) -> Dictionary<String, Any> {
//        
//        let data: Dictionary<String, Any> = [Constants.User.FIRST_NAME: user.firstname ?? "", Constants.User.SURNAME: user.surname ?? "",   Constants.User.EMAIL: user.email ?? "", Constants.User.UID: user.uid ?? "", Constants.User.USERNAME: user.username ?? "",
//            Constants.User.FRIENDS: user.friends]
//        
//        return data
//    }
//    
}
