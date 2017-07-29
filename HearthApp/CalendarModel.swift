//
//  Calendar.swift
//  HearthApp
//
//  Created by Adam Zvada on 27.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class CalendarModel {
    
    var userRegistration: CalendarDate?
    
    func setUserRegistrationDate(date: CalendarDate) {
        userRegistration = date
    }
    
    /*
     * Return date from current day minus index as days
     */
    func dateByIndex(index: Int) -> CalendarDate {
        let date = NSCalendar.currentCalendar().dateByAddingUnit( [.Day], value: index, toDate: NSDate(), options: [] )!
    }
    
    func daysFromRegistration() -> Int {
        let registrationDate = DateFormatter.
        
        
    }
    
    func currentDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.day, from: date)
        return minutes
    }
    
    func currentMonth() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.day, from: date)
        return minutes
    }
    
    func currentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.day, from: date)
        return minutes
    }
}
