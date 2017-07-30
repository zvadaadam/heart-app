//
//  CalendarDate.swift
//  HearthApp
//
//  Created by Adam Zvada on 29.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation


struct CalendarDate {
    var day: Int;
    var month: Int;
    var year: Int;
    
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    func getMonthStr() -> String {
        switch month {
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAY"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
        default:
            return ""
        }
    }
}
