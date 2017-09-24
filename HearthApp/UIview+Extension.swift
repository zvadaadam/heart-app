//
//  UIview+Extension.swift
//  HearthApp
//
//  Created by Adam Zvada on 24.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}
