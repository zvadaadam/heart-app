//
//  HeartHandler.swift
//  HearthApp
//
//  Created by Adam Zvada on 20.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class HeartHandler {
    static let sharedInstance = HeartHandler()
    
    var dbProvider = DBProvider.sharedInstance
    var authProvide = AuthProvider.sharedInstance
    
    func storeHeartRate(heartRates: [HeartRate]) {
        for heartRate in heartRates {
            if let timestamp = heartRate.timestamp, let rate = heartRate.rate {
                dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).child(String(timestamp)).setValue(rate)
            }
        }
    }
    
    func loadHeartRate(fromTimestamp: Int, toTimestamp: Int, complition: @escaping ([HeartRate]) -> Void) {
        dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).queryStarting(atValue: fromTimestamp).queryEnding(atValue: toTimestamp).observeSingleEvent(of: .value, with: { (snapshot) in
            var hearRates: [HeartRate] = []
            if let dictionary = snapshot.value as? [String : Any] {
                for (key, value) in dictionary {
                    if let timestamp = Int(key), let rate = value as? Double {
                        let heartRate = HeartRate(rate: rate, timestamp: timestamp)
                        hearRates.append(heartRate)
                    }
                }
            }
            complition(hearRates)
        }, withCancel: nil)
    }
    
}
