//
//  AddFriendsViewModel.swift
//  HearthApp
//
//  Created by Adam Zvada on 18.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

protocol AddFriendsViewModelDelegate: class {
    func searchedUser(user: [User])
}


class AddFriendsViewModel {
    
    var userHandler: UserHandler
    
    var authProvider: AuthProvider = AuthProvider.sharedInstance
    
    weak var delegate: AddFriendsViewModelDelegate?
    
    var users: [User] = []
    
    //UserHandler should be generic protocol, DI
    init(userHandler: UserHandler = UserHandler.sharedInstance) {
        self.userHandler = userHandler
    }
    
    func searchUser(name: String) {
        userHandler.getUsers { (users) in
            self.users = []
            for user in users {
                self.users.append(user)
            }
            
            self.delegate?.searchedUser(user: users)
        }
    }
    
    func addFriend(FID: String) {
        userHandler.addFriendToUser(UID: authProvider.currentUID()!, FID: FID)
    }
    
    func removeFriend(FID: String) {
        userHandler.removeFriendFromUser(UID: authProvider.currentUID()!, FID: FID)
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
}

