//
//  CalendarTodayCollectionViewCell.swift
//  HearthApp
//
//  Created by Adam Zvada on 27.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

class CalendarTodayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var today: UILabel?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                animateChangeLabel(color: .red)
            } else {
                animateChangeLabel(color: .white)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isSelected = true
    }

    func selectToday() {
        animateChangeLabel(color: .red)
    }
    
    func unselectToday() {
        self.today?.textColor = .white
    }
    
    func todayPressed() {
        if isSelected {
            isSelected = false
            //today?.textColor = UIColor.red
        } else {
            isSelected = true
            //today?.textColor = UIColor.white
        }
    }
    
    func animateChangeLabel(color: UIColor) {
        today?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
            self.today?.transform = .identity
            self.today?.textColor = color
        }, completion: nil)

    }
}

extension UILabel {
    
}
