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
    var healthManager = HealthKitManager.sharedInstance
    
    func storeHeartRate(heartRates: [HeartRate]) {
        for heartRate in heartRates {
            if let timestamp = heartRate.timestamp, let rate = heartRate.rate {
                dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).child(String(timestamp)).setValue(rate)
            }
        }
    }
    
    
    func storePossibleHeartRateInTime(fromTimestamp: Double, toTimestamp: Double) {
        lastHeartRate { (lastHeartRate) in
            var newFromTimestamp = fromTimestamp
            if let lastUpload = lastHeartRate.timestamp {
                if lastUpload > fromTimestamp {
                    newFromTimestamp = lastUpload
                }
            }
            
            if newFromTimestamp < toTimestamp {
                self.storeHeartRateInTime(fromTimestamp: newFromTimestamp, toTimestamp: toTimestamp)
            }
        }
    }
    
    func storeHeartRateInTime(fromTimestamp: Double, toTimestamp: Double) {
        healthManager.readHeartRateEntity(from: Date(timeIntervalSince1970: fromTimestamp), to: Date(timeIntervalSince1970: toTimestamp)) { (heartRates, error) in
            for heartRate in heartRates {
                if let timestamp = heartRate.timestamp, let rate = heartRate.rate {
                    self.dbProvider.heartOfUserRef(UID: self.authProvide.currentUID()!).child(String(Int(timestamp))).setValue(rate)
                }
            }
        }
    }
    
    func loadHeartRate(fromTimestamp: Double, toTimestamp: Double, complition: @escaping ([HeartRate]) -> Void) {
        dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).queryOrderedByKey().queryStarting(atValue: String(1506268568)).queryEnding(atValue: String(1506268882)).observeSingleEvent(of: .value, with: { (snapshot) in
            var hearRates: [HeartRate] = []
            if let dictionary = snapshot.value as? [String : Any] {
                for (key, value) in dictionary {
                    if let timestamp = Double(key), let rate = value as? Double {
                        let heartRate = HeartRate(rate: rate, timestamp: timestamp)
                        hearRates.append(heartRate)
                    }
                }
            }
            complition(hearRates)
        }, withCancel: nil)
    }
    
    func lastHeartRate(complition: @escaping (HeartRate) -> Void) {
        dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? (String, Any) {
                print(dictionary)
            }
            
            if let (key, value) = snapshot.value as? (Double, Double) {
                complition(HeartRate(rate: key, timestamp: value))
            }
        })
    }
    
}
