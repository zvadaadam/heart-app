//
//  ProfileViewModel.swift
//  HearthApp
//
//  Created by Adam Zvada on 17.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import HealthKit
import Foundation
import UIKit


protocol ProfileViewModelProtocol: class {
    func setProfileImage(image: UIImage)
    func setProfileInfo(user: User)
}

class ProfileViewModel {
    
    var heartHandler: HeartHandler = HeartHandler.sharedInstance
    var userHandler: UserHandler = UserHandler.sharedInstance
    var authProvider: AuthProvider = AuthProvider.sharedInstance
    var healthManager: HealthKitManager = HealthKitManager.sharedInstance
    
    var user: User?
    
    weak var delegate: ProfileViewModelProtocol?
    
    func authorizeHealthKit() {
        healthManager.authorizeHealthKit { (authorization, error) in
            if error == nil && authorization == true {
                print("HealthKit Access Obtained")
            } else {
                print("HealthKit Access Denined")
            }
        }
    }
    
    func loadUser(complition: @escaping (User) -> Void) {
        userHandler.getUser(UID: authProvider.currentUID()!) { (user) in
            self.user = user
            complition(user)
        }
    }
    
    func saveUserProfile(user: User) {
        userHandler.updateCurrentUser(user: user)
    }
    
    func saveProfileImage(image: UIImage) {
        userHandler.storeProfileImage(image: image)
    }
    
    func retriveProfileImage() {
        userHandler.loadProfileImage { (image) in
            self.delegate?.setProfileImage(image: image)
        }
    }
    
    func retriveUserData() {
        loadUser { (user) in
            self.delegate?.setProfileInfo(user: user)
            
            self.userHandler.loadProfileImageWithUser(user: user, complition: { (image) in
                self.delegate?.setProfileImage(image: image)
            })
        }
    }
    
//    func updateHeartData() {
//        healthManager.readTodayRate(completion: { (heartSample, error) in
//            heartSample[0].
//            
//            let heartBeats = (heartSample as! HKQuantitySample).quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
//            var heartRates = []
//            for hearyNear in heartBeats {
//                heartRates.append(HeartRate(rate: <#T##Double#>, timestamp: <#T##Int#>))
//            }
//            self.heartHandler.storeHeartRate(heartRates: )
//        })
//    }
}
