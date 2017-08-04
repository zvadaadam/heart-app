//
//  FriendsSelectedView.swift
//  HearthApp
//
//  Created by Adam Zvada on 03.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

@IBDesignable
class FriendsSelectedView: UIView {

    var view: UIView!
    
    static let size: CGFloat = 70
    
    
    @IBInspectable var circleWidth: CGFloat = 3
    
    @IBInspectable var colorStroke: UIColor = UIColor.clear {
        didSet {
            view.setNeedsDisplay()
        }
    }
    
    var userName: String = "Unknown" {
        didSet {
            nameLabel.text = userName
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        profileImage.circleImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        profileImage.circleImage()
    }
    
    
    func xibSetup() {
        view = instanceFromNib()
        addSubview(view)
        view.frame = self.bounds
    }
    
    func instanceFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FriendsSelectedView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setColor(color: UIColor) {
        colorStroke = color
    }
    
    func setName(name: String) {
        userName = name
    }
    
    override func draw(_ rect: CGRect) {
        
        let origin = CGPoint(x: profileImage.center.x, y: profileImage.center.y)
        let radius = profileImage.frame.height/2 + circleWidth
        
        let path = UIBezierPath(arcCenter: origin, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = colorStroke.cgColor
        shapeLayer.lineWidth = circleWidth
        
        self.layer.addSublayer(shapeLayer)

    }
}
