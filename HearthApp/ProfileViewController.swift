//
//  ProfileViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 01.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var weightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.circleImage()
    }

}
