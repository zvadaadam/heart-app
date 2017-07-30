//
//  CalendarCollectionViewCell.swift
//  HearthApp
//
//  Created by Adam Zvada on 27.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CalendarCollectionViewCell: UICollectionViewCell {

    let circleWidth: CGFloat = 2
    
    @IBOutlet weak var day: UILabel?
    @IBOutlet weak var month: UILabel?
    
    var fillCircle: CGColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fillCircle = UIColor.clear.cgColor
    }
    
    func setDayLabel(day: String, month: String) {
        self.day?.text = day
        self.month?.text = month
    }
    
    func selectCell() {
        fillCircle = UIColor.white.cgColor
        day?.textColor = UIColor.red
        month?.textColor = UIColor.red
    }
    
    func unselectCell() {
        fillCircle = UIColor.clear.cgColor
        day?.textColor = UIColor.white
        month?.textColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        
        let origin = CGPoint(x: rect.width/2, y: rect.height/2)
        let radius = rect.height/2 - circleWidth
        let path = UIBezierPath(arcCenter: origin, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillCircle
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = circleWidth
        
        if (self.layer.sublayers?[0] as? CAShapeLayer) != nil {
            self.layer.sublayers?[0] = shapeLayer
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
    }

}
