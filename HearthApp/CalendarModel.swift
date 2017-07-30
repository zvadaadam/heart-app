//
//  Calendar.swift
//  HearthApp
//
//  Created by Adam Zvada on 27.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class CalendarModel {
    
    var userRegistration: CalendarDate = CalendarDate(day: 1, month: 7, year: 2017)
    
    var selectedItem: Int = 0
    
    func selectItemAt(index: Int) {
        selectedItem = index
    }
    
    
    func setUserRegistrationDate(date: CalendarDate) {
        userRegistration = date
    }
    
    
    func getDaysFromRegistration() -> Int {
        return daysBetween(date1: getUserRegistrationDate(), date2: Date())
    }
    
    func subtractDaysFromCurrent(days: Int) -> CalendarDate {
        let currentDate = Date()
        let pastDate = currentDate.addingTimeInterval(TimeInterval(-days*24*60*60))
        
        return CalendarDate(day: dateDay(date: pastDate), month: dateMonth(date: pastDate), year: dateYear(date: pastDate))
    }
    
    func getUserRegistrationDate() -> Date {
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation()!)
        
        let userDay = String(userRegistration.day)
        let userMonth = String(userRegistration.month)
        let userYear = String(userRegistration.year)
        
        let dateString = String(userYear + "-" + userMonth + "-" + userDay)
        return dateformatter.date(from: dateString!)!
    }
    
    func daysBetween(date1: Date, date2: Date) -> Int {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: date1)
        let date2 = calendar.startOfDay(for: date2)
        
        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
        
        return components.day! + 1
    }
    
    func dateDay(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func dateMonth(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
    }
    
    func dateYear(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
}
