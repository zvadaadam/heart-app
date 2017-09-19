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
    
    @IBOutlet weak var firstnameField: CustomTextField!
    
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


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func profileImageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            profileImage.image = editedImage
            editedImage.printMemory()
        } else if let originalPhoto = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            profileImage.image = originalPhoto
            originalPhoto.printMemory()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

extension UIImage {
    func printMemory() {
        let imgData: NSData = NSData(data: UIImageJPEGRepresentation((self), 1)!)
        let imageSize: Int = imgData.length
        print("Size of image in KB: %f ", Double(imageSize) / 1024.0)
    }
}
