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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDayLabel(day: String, month: String) {
        self.day?.text = day
        self.month?.text = month
    }
    
    override func draw(_ rect: CGRect) {
        print(rect.origin)
        print(CGPoint(x: rect.width/2, y: rect.height/2))
        let origin = CGPoint(x: rect.width/2, y: rect.height/2)
        let radius = rect.height/2 - circleWidth
        let path = UIBezierPath(arcCenter: origin, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        //let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: rect.width/2, y: rect.height/2), size: CGSize(width: rect.size.width - 3 , height: rect.size.height - 3)))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = circleWidth
        
        self.layer.insertSublayer(shapeLayer, at: 0)
    }}
