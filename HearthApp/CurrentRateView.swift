//
//  CurrentRateView.swift
//  HearthApp
//
//  Created by Adam Zvada on 22.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CurrentRateView : UIView {
    
    var view: UIView!
    
    @IBInspectable var outterRingColor : UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var filledColor : UIColor = .init(colorLiteralRed: 40/255, green: 40/255, blue: 40/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var currentRate: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = instanceFromNib()
        addSubview(view)
        view.frame = self.bounds
        
        //view.translatesAutoresizingMaskIntoConstraints = false
        //view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func instanceFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CurrentRateView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public func changeRateValue(rate: Int, colorRing: UIColor) {
        currentRate.text = String(rate)
        outterRingColor = colorRing
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = filledColor.cgColor
        //shapeLayer.strokeColor = outterRingColor.cgColor
        //shapeLayer.lineWidth = 3
        view.layer.insertSublayer(shapeLayer, at: 0)
        
    }
    
}

