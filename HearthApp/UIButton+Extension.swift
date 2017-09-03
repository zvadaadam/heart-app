//
//  UIButton+Extension.swift
//  HearthApp
//
//  Created by Adam Zvada on 03.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

extension UIButton {
    func disable() {
        self.isEnabled = false
        self.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    func enable() {
        self.isEnabled = true
        self.setTitleColor(UIColor.red, for: .normal)
    }
}
