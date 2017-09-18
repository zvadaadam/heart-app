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
    
    @IBOutlet weak var firstnameField:CustomTextField!
    
    @IBOutlet weak var surnameField: CustomTextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var yearField: CustomTextField!
    
    @IBOutlet weak var weightField: CustomTextField!
    
    let viewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.circleImage()
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        usernameLabel.text = UserDefaults.standard.value(forKey: Constants.User.USERNAME) as? String
    }
    
    func saveTapped() {
        
//        firstnameField.resignFirstResponder()
//        surnameField.resignFirstResponder()
//        yearField.resignFirstResponder()
//        weightField.resignFirstResponder()
        
        
        let user = User(firstname: firstnameField.text!, surname: surnameField.text!, gender: "Male", yearOfBirth: yearField.text!, weight: weightField.text!)
        
        viewModel.saveUserProfile(user: user)
        
        //PresentStoryboard.sharedInstance.showGraph(vc: self)
        PresentStoryboard.sharedInstance.showAddFriends(vc: self)
    }
    
    

}


