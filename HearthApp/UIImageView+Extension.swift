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
    
    func loadImageWithURL(urlString: String) {
        if let myUrl = URL(string: urlString) {
            URLSession.shared.dataTask(with: myUrl, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                print("Size of retrived photos is \((data?.count)!/1024)KB")
                self.image = UIImage(data: data!)
            }).resume()
        }
        
    }
}
