//
//  UIImageView+Extension.swift
//  HearthApp
//
//  Created by Adam Zvada on 03.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

extension UIImageView {
    
    
    
    func circleImage() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
