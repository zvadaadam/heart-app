//
//  TimeZoneHelper.swift
//  HearthApp
//
//  Created by Adam Zvada on 26.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation


class TimeZoneHelper {
    
    static func firebaseDate(date: Date) -> Date {
        return Date(timeIntervalSince1970: (date.timeIntervalSince1970 - Double(NSTimeZone.system.secondsFromGMT())))
    }
    
    static func localDate(date: Date) -> Date {
        return Date(timeIntervalSince1970: (date.timeIntervalSince1970 + Double(NSTimeZone.system.secondsFromGMT())))
    }
    
    static func firebaseDate(timestamp: Double) -> Double {
        return timestamp - Double(NSTimeZone.system.secondsFromGMT())
    }
    
    static func localDate(timestamp: Double) -> Double {
        return timestamp + Double(NSTimeZone.system.secondsFromGMT())
    }
    
}
