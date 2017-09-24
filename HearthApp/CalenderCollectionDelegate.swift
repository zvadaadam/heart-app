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
        print(calendarModel.getDaysFromRegistration())
        return calendarModel.getDaysFromRegistration()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.item)
        var cell : UICollectionViewCell? = nil
        if indexPath.item != 0 {
            let reuseCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCollectionViewCell
            let dayCalendar = calendarModel.subtractDaysFromCurrent(days: indexPath.item)
            reuseCell.setDayLabel(day: String(dayCalendar.day), month: dayCalendar.getMonthStr())
            reuseCell.fillCircle = UIColor.clear.cgColor
            
            (indexPath.item == calendarModel.selectedItem ? reuseCell.selectCell() : reuseCell.unselectCell())
            
            cell = reuseCell
        } else {
            let reuseCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCellToday", for: indexPath) as! CalendarTodayCollectionViewCell
            (indexPath.item == calendarModel.selectedItem ? reuseCell.selectToday() : reuseCell.unselectToday())
            cell = reuseCell
        }
        
        
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.item != calendarModel.selectedItem else {
            return
        }
        
        calendarModel.selectItemAt(index: indexPath.item)
        calendar.reloadData()
        
        let date = calendarModel.subtractDaysFromCurrent(days: indexPath.item)
        
        print(String(date.day) + "-" + date.getMonthStr() + "-" + String(date.year))
        
        print(Date().getDate(day: date.day + 1, month: date.month, year: date.year))
        
        getGraphOfDate(date: Date().getDate(day: date.day + 1, month: date.month, year: date.year))
    }
    
    
}
