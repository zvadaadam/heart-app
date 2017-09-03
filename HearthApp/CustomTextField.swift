//
//  CustomTextField.swift
//  HearthApp
//
//  Created by Adam Zvada on 02.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit


class CustomTextField: UITextField {
    
    init(frame: CGRect, size: CGFloat) {
        super.init(frame: frame)
        
        initTextFieldProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initTextFieldProperties()
    }
    
    func initTextFieldProperties() {
        self.underlined()
        
        self.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textFieldEditingStarted), for: .editingDidBegin)
    }
    
    func textFieldEditingDidEnd() {
        guard self.text != nil && !(self.text?.isEmpty)! else {
            self.text = self.placeholder
            return
        }
    }
    
    func textFieldEditingStarted() {
        guard self.text != self.placeholder else {
            self.text = ""
            return
        }
    }
}

