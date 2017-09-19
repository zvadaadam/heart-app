//
//  UserHandler.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

@objc protocol FetchUsersData: class {
    @objc optional func recivedAllUsers(users: [User])
    @objc optional func recivedUserData(user: User)
    @objc optional func recivedUserDataWithFriends(user: User)
    @objc optional func recivedProfileImage(image: UIImage)
}

//TODO : Add Dependecy Injection
class UserHandler {

    static let sharedInstance = UserHandler()
    
    //TODO : CHANGE TO CONTAINER
    var authProvider: AuthProvider = AuthProvider.sharedInstance
    
    //TODO : CHANGE TO CONTAINER
    var dbProvider: DBProvider = DBProvider.sharedInstance
    
    //TODO : CHANGE TO CONTAINER
    var cache: MyCache = MyCache.sharedInstance
    
    weak var delegate: FetchUsersData?
    
    func addUser(user: User) {
        
        //let data = createDictionaryWith(user: user)
        let data = user.createUserDictionary()
        
        //DBProvider.sharedInstance.userRef.child(user.uid!).setValue(data)
        dbProvider.profileRef(UID: user.uid!).setValue(data)
    }
    
    func addFriendToUser(UID: String, FID: String) {
        dbProvider.friendsOfUser(UID: UID).child(Constants.User.FRIENDS).setValue(FID)
    }
    
    func removeFriendFromUser(UID: String, FID: String) {
        dbProvider.friendsOfUser(UID: UID).child(Constants.User.FRIENDS).child(FID).removeValue()
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
    
    func getUser(UID: String, completion: @escaping (User) -> Void) {
        dbProvider.profileRef(UID: UID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User()
                user.setValuesForKeys(dictionary)
                completion(user)
            }
        })
    }
    
//    func getAllUsers() {
//        dbProvider.userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//
//            print(snapshot)
//            
//            if let dictionary = snapshot.value as? [String : Any] {
//                
//            }
//        })
//    }
    
//    func getUser(UID: String) {
//        DBProvider.sharedInstance.profileRef(UID: UID).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            print(snapshot)
//            
//            if let dictionary = snapshot.value as? [String : Any] {
//                print("===FOO===")
//                print(dictionary)
//            }
//            
//            if let user = snapshot.value as? User {
//                self.delegate?.recivedUserData(user: user)
//            }
//            
//            
//        })
//    }
    
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
    
    
    
    func storeProfileImage(image: UIImage) {
        
        createStorageForProfileImage(image: image) { (imageURL) in
            self.dbProvider.profileRef(UID: self.authProvider.currentUID()!).updateChildValues([Constants.User.PROFILE_URL : imageURL.absoluteString])
        }
    }
    
    func createStorageForProfileImage(image: UIImage, completion: @escaping (URL) -> Void) {
        let storageRef = dbProvider.storageRef.child("\(NSUUID().uuidString).png")
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.1) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let myMetaData = metadata {
                    print("Succes of image store.")
                    print(myMetaData)
                    
                    completion(myMetaData.downloadURL()!)
                }
            })
        }
    }
    
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
    
    func loadProfileImage(complition: @escaping (UIImage) -> Void) {
        self.getUser(UID: authProvider.currentUID()!) { (user) in
            guard let profileURL = user.profileImageURL, profileURL != "" else {
                return
            }
            
            if let cacheImage = self.cache.imageCache.object(forKey: profileURL as NSString) {
                complition(cacheImage)
                return
            }
            
            if let myUrl = URL(string: profileURL) {
                URLSession.shared.dataTask(with: myUrl, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    guard let myData = data, let image = UIImage(data: myData)  else {
                        return
                    }
                    print("Size of retrived photos is \((data?.count)!/1024)KB")
                    self.cache.imageCache.setObject(image, forKey: profileURL as NSString)
                    complition(image)
                }).resume()
            }
        }
    }
    
    func loadProfileImageWithUser(user: User, complition: @escaping (UIImage) -> Void) {
        guard let profileURL = user.profileImageURL, profileURL != "" else {
            return
        }
        
        if let cacheImage = self.cache.imageCache.object(forKey: profileURL as NSString) {
            complition(cacheImage)
            return
        }
        
        if let myUrl = URL(string: profileURL) {
            URLSession.shared.dataTask(with: myUrl, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let myData = data, let image = UIImage(data: myData)  else {
                    return
                }
                print("Size of retrived photos is \((data?.count)!/1024)KB")
                self.cache.imageCache.setObject(image, forKey: profileURL as NSString)
                complition(image)
            }).resume()
        }

    }
}
