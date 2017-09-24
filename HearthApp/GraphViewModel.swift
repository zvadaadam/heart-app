//
//  GraphViewModel.swift
//  HearthApp
//
//  Created by Adam Zvada on 24.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

protocol GraphViewModelDelegate: class {
    func retrivedHeartRates(date: Date, heartRates: [HeartRate])
}

class GraphViewModel {
    
    var heartHandler: HeartHandler = HeartHandler.sharedInstance
    var authProvider: AuthProvider = AuthProvider.sharedInstance

    weak var delegate: GraphViewModelDelegate?
    
    func retriveHeartRates(date: Date) {
        let beginOfDay = date.startOfDay.timeIntervalSince1970
        let endOfDay = date.endOfDay?.timeIntervalSince1970
        
        heartHandler.loadHeartRate(fromTimestamp: beginOfDay, toTimestamp: endOfDay!) { (heartRates) in
            self.delegate?.retrivedHeartRates(date: date, heartRates: heartRates)
        }
    }
}
