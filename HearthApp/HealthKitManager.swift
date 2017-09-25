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
    
    let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending: false)
    
    func authorizeHealthKit(completion:((_ mySuccess : Bool, _ myError : Error?) -> Void)!) {
        
        let HKTypesToRead = Set([HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]);
        
        healthKitStore.requestAuthorization(toShare: nil, read: HKTypesToRead){ (success, error) -> Void in
            if completion != nil {
                completion(success, error)
            }
        }
    }
    
    
    func readHeartRate(from: Date, to: Date, completion: @escaping ([HKSample], NSError?) -> Void) {
     
        let predicate = HKQuery.predicateForSamples(withStart: from, end: to)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) -> Void in
            
            if let queryError = error {
                completion([], queryError as NSError)
                return
            }
            
//            for beat in results! {
//                print("\(beat.startDate) VS  \(beat.endDate)")
//                print(beat.startDate)
//                let hBeat = beat as! HKQuantitySample
//                print(hBeat.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
//            }
            
            if let sample = results {
                completion(sample, nil)
            }
        }
        healthKitStore.execute(sampleQuery);
    }
    
    func readHeartRateEntity(from: Date, to: Date, completion: @escaping ([HeartRate], NSError?) -> Void) {
        self.readHeartRate(from: from, to: to) { (result, error) in
            if error != nil {
                completion([], nil)
            }
            
            //DEBUG
            print("READING HEART DATA from \(from) to \(to)")
            print("Number of HeartData = \(result.count)")
            
            var heartRate: [HeartRate] = []
            
            for beatSample in result {
                let beatValaue = (beatSample as! HKQuantitySample).quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                let beat = HeartRate(rate: beatValaue, timestamp: Double(beatSample.startDate.timeIntervalSince1970))
                heartRate.append(beat)
            }
            
            completion(heartRate, nil)
        }
    }
    
    func readTodayRate(completion: @escaping ([HKSample], NSError?) -> Void) {
        let yeasterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        print(yeasterday!)
        print(Date())
        
        readHeartRate(from: yeasterday!, to: Date()) { (results, error) in
            if let queryError = error {
                completion([], queryError as NSError)
                return
            }
            completion(results, nil)
        }
    }
}


