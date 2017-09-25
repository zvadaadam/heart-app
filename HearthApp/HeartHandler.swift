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
            dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).child(String(heartRate.timestamp)).setValue(heartRate.rate)
        }
    }
    
    
    func storePossibleHeartRateInTime(fromTimestamp: Double, toTimestamp: Double) {
        lastHeartRate { (lastHeartRate) in
            guard let lastHR = lastHeartRate else {
                self.storeHeartRateInTime(fromTimestamp: fromTimestamp, toTimestamp: toTimestamp)
                return
            }
            
            var newFromTimestamp = fromTimestamp
            if lastHR.timestamp > fromTimestamp {
                newFromTimestamp = lastHR.timestamp
            }
            
            
            if newFromTimestamp < toTimestamp {
                self.storeHeartRateInTime(fromTimestamp: newFromTimestamp, toTimestamp: toTimestamp)
            }
        }
    }
    
    func storeHeartRateInTime(fromTimestamp: Double, toTimestamp: Double) {
        healthManager.readHeartRateEntity(from: Date(timeIntervalSince1970: fromTimestamp), to: Date(timeIntervalSince1970: toTimestamp)) { (heartRates, error) in
            //DEBUG
            print("Storing to Firebase...")
            for heartRate in heartRates {
                let date = Date(timeIntervalSince1970: heartRate.timestamp)
                print("\(date) and HR: \(heartRate.rate)")
                self.dbProvider.heartOfUserRef(UID: self.authProvide.currentUID()!).child(String(Int(heartRate.timestamp))).setValue(heartRate.rate)
            }
        }
    }
    
    func loadHeartRate(fromTimestamp: Double, toTimestamp: Double, complition: @escaping ([HeartRate]) -> Void) {
        
        dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).queryOrderedByKey().queryStarting(atValue: String(Int(fromTimestamp))).queryEnding(atValue: String(Int(toTimestamp))).observeSingleEvent(of: .value, with: { (snapshot) in
            //DEBUG
            print("Loading heart data from Firebase...")
            print("From \(Date(timeIntervalSince1970: fromTimestamp)) to \(Date(timeIntervalSince1970: toTimestamp))")
            
            var hearRates: [HeartRate] = []
            if let dictionary = snapshot.value as? [String : Any] {
                for (key, value) in dictionary {
                    if let timestamp = Double(key), let rate = value as? Double {
                        let heartRate = HeartRate(rate: rate, timestamp: timestamp)
                        print("\(Date(timeIntervalSince1970: timestamp)) and HR: \(rate)")
                        hearRates.append(heartRate)
                    }
                }
            }
            complition(hearRates)
        }, withCancel: nil)
    }
    
    func lastHeartRate(complition: @escaping ((HeartRate?) -> Void)) {
        dbProvider.heartOfUserRef(UID: authProvide.currentUID()!).queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { (snapshot) in
                    
            if let dictionary = snapshot.value as? [String: Any] {
                if let lastHR = dictionary.first {
                    complition(HeartRate(rate: (lastHR.value as? Double)!, timestamp: Double(lastHR.key)!))
                } else {
                    complition(nil)
                }
            } else {
                complition(nil)
            }
        })
    }
    
}
