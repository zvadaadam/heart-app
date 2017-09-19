//
//  HealthKitManager.swift
//  HearthApp
//
//  Created by Adam Zvada on 20.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealthKitManager : NSObject {
    
    static let sharedInstance = HealthKitManager()
    
    let healthKitStore = HKHealthStore()
    
    
    func authorizeHealthKit(completion:((_ mySuccess : Bool, _ myError : Error?) -> Void)!) {
        
        let HKTypesToRead = Set([HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]);
        
        
        healthKitStore.requestAuthorization(toShare: nil, read: HKTypesToRead){ (success, error) -> Void in
            if completion != nil {
                completion(success, error)
            }
        }
        return;
    }
    
    func readHeartBeatRecent() -> Double? {
        
        var heartBeat : HKQuantitySample?
        
        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
        
        readMostRecentSample(sampleType: sampleType!, completion: { (mostRecentBeat, error) -> Void in
            if error != nil {
                print("Error in reading heart beat data, \(String(describing: error?.localizedDescription))")
                return
            }
            heartBeat = mostRecentBeat as? HKQuantitySample
        })
        
        return heartBeat?.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()));
    }
    
    func readMostRecentSample(sampleType : HKSampleType, completion: ((HKSample?, NSError?) -> Void)!) {
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: NSDate.distantPast, end: NSDate() as Date)
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) -> Void in
            if let queryError = error {
                completion(nil, queryError as NSError)
                return;
            }
            
            // Get the first sample
            let mostRecentSample = results?.first
            
            // Execute the completion closure
            if completion != nil {
                completion(mostRecentSample, nil)
            }
        }
        
        healthKitStore.execute(sampleQuery);
    }
    
//    func readHeartBeat() -> [Heart] {
//        var hearts : [Heart] = []
//        
//        
//        //Mocked pulses
//        hearts.append(Heart(timestamp: "00:00", puls: 90))
//        //hearts.append(Heart(timestamp: "00:00", puls: Int8(getRndPuls())))
//        hearts.append(Heart(timestamp: "00:15", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "00:30", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "00:45", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "01:00", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "01:15", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "01:30", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "01:45", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "02:00", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "02:15", puls: getRndPuls()))
//        hearts.append(Heart(timestamp: "02:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "02:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "03:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "03:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "03:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "03:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "04:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "04:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "04:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "04:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "05:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "05:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "05:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "05:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "06:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "06:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "06:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "06:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "07:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "07:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "07:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "07:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "08:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "08:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "08:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "08:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "09:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "09:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "09:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "09:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "10:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "10:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "10:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "10:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "11:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "11:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "11:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "11:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "12:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "12:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "12:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "12:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "13:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "13:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "13:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "13:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "14:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "14:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "14:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "14:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "15:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "15:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "15:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "15:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "16:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "16:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "16:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "16:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "17:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "17:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "17:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "17:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "18:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "18:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "18:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "18:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "19:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "19:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "19:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "19:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "20:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "20:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "20:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "20:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "21:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "21:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "21:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "21:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "22:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "22:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "22:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "22:45", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "23:00", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "23:15", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "23:30", puls: (getRndPuls())))
//        hearts.append(Heart(timestamp: "23:45", puls: (getRndPuls())))
//        
//        return hearts
//    }
    
    func getRndPuls() -> UInt32 {
        return (arc4random_uniform(150) + 40)
    }
}


