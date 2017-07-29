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
}
