//
//  FriendsHandler.swift
//  HearthApp
//
//  Created by Adam Zvada on 30.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol FetchFriendsData: class {
    func recivedFriendsUID(UIDs: [String])
}

class FriendsHandler {
    static let sharedInstance = FriendsHandler()
    
    weak var delegate: FetchFriendsData?
    
    func addFriend(currentUID: String, friendsUID: String) {
        let friend: Dictionary<String, Any> = [Constants.FRIENDS: friendsUID]
        DBProvider.sharedInstance.friendsOfUser(UID: currentUID).updateChildValues(friend)
    }
    
    func getFriends(currentUID: String) {
        DBProvider.sharedInstance.friendsOfUser(UID: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            var friendsUID = [String]()
            
            if let myFriendsUIDs = snapshot.value as? [String] {
                for friendUID in myFriendsUIDs {
                    friendsUID.append(friendUID)
                }
            }
            self.delegate?.recivedFriendsUID(UIDs: friendsUID)
        })
    }
    
}
