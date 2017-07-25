//
//  LaunchController.swift
//  HearthApp
//
//  Created by Adam Zvada on 15.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit


class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: ViewConstants.LOGIN) as! LoginViewController
        self.present(VC, animated: true, completion: nil)
    }
    
    
    @IBAction func SignUpTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: ViewConstants.SIGN_UP) as! SignUpViewController
        //let navigationVC = UINavigationController(rootViewController: VC)
        self.present(VC, animated: true, completion: nil)
    }
}
