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
        return
    }
    
    
    func readLastDayHeartBeat(completion: @escaping ([HKSample], NSError?) -> Void) {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
        let yeasterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        print(yeasterday!)
        print(Date())
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: yeasterday!, end: Date())
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
    
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) -> Void in
            if let queryError = error {
                completion([], queryError as NSError)
                return;
            }
            
            if let sample = results {
                completion(sample, nil)
            }
//            for beat in results! {
//                let hBeat = beat as! HKQuantitySample
//                
//                print(hBeat.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
//            }
        }
        
        healthKitStore.execute(sampleQuery);
    }
}


