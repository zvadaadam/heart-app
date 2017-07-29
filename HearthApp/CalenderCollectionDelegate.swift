//
//  CalenderCollectionDelegate.swift
//  HearthApp
//
//  Created by Adam Zvada on 27.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

extension GraphViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell? = nil
        if indexPath.item != 0 {
            cell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCollectionViewCell
            (cell as! CalendarCollectionViewCell).setDayLabel(day: "30", month: "JUN")
        } else {
            cell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCellToday", for: indexPath) as! CalendarTodayCollectionViewCell
        }
        
        
        
        return cell!
    }
    
    
    
}
