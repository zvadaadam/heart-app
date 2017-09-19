//
//  Cache.swift
//  HearthApp
//
//  Created by Adam Zvada on 19.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
class MyCache {
    
    //TODO: DI
    static let sharedInstance = MyCache()
    
    let imageCache = NSCache<NSString, UIImage>()
    
}
