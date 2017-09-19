//
//  CircleImageView.swift
//  HearthApp
//
//  Created by Adam Zvada on 19.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    @IBInspectable var circleWidth: CGFloat = 3
    
    @IBInspectable var colorStroke: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    init(frame: CGRect, size: CGFloat) {
        super.init(frame: frame)
        createCircleImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircleImage()
    }
    
    func createCircleImage() {
        self.circleImage()
        
        layer.borderColor = colorStroke.cgColor
        layer.borderWidth = circleWidth
    }
}
