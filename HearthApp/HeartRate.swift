//
//  HeartRate.swift
//  HearthApp
//
//  Created by Adam Zvada on 21.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

class HeartRate {
    
    var timestamp: Int?
    var rate: Double?
    
    init(rate: Double, timestamp: Int) {
        self.rate = rate
        self.timestamp = timestamp
    }
    
    
    
}
