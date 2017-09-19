//
//  ProfileViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 01.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit
import ImagePicker

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

        self.hideKeyboardOnTap()
        
        profileImage.circleImage()
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.profileImageTapped)))
        profileImage.isUserInteractionEnabled = true
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        usernameLabel.text = UserDefaults.standard.value(forKey: Constants.User.USERNAME) as? String
    }
    
    func saveTapped() {
        
        let user = User(firstname: firstnameField.text!, surname: surnameField.text!, gender: "Male", yearOfBirth: yearField.text!, weight: weightField.text!)
        
        viewModel.saveUserProfile(user: user)
        
        //PresentStoryboard.sharedInstance.showGraph(vc: self)
        PresentStoryboard.sharedInstance.showAddFriends(vc: self)
    }
    

}


extension ProfileViewController: ImagePickerDelegate {
    
    func profileImageTapped() {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowMultiplePhotoSelection = false
        
        let picker = ImagePickerController()
        picker.delegate = self
        picker.configuration = config
        //picker.imageLimit = 1
        picker.startOnFrontCamera = true
        picker.preferredImageSize = CGSize(width: 100, height: 100)
        present(picker, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else {
            return
        }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if images.count != 0 {
            profileImage.image = images[0]
        }
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
