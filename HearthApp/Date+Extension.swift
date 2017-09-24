//
//  Date+Extension.swift
//  HearthApp
//
//  Created by Adam Zvada on 24.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    func dateWithTimezone(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat =  format
        return dateFormatter.string(from: self)
    }
    
    func getDate(day: Int, month: Int, year: Int) -> Date {
        var component = DateComponents()
        component.year = year
        component.month = month
        component.day = day
        component.minute = 0
        component.hour = 0
        component.second = 0
        
        print(Calendar.current.date(from: component)!)
        
        return Calendar.current.date(from: component)!
    }
    
    
}
