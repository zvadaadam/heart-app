//
//  ProfileViewModel.swift
//  HearthApp
//
//  Created by Adam Zvada on 17.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var userHandler: UserHandler = UserHandler.sharedInstance
    var authProvider: AuthProvider = AuthProvider.sharedInstance
    
    
    func saveUserProfile(user: User) {
        userHandler.updateCurrentUser(user: user)
    }
    
}
