//
//  ProfileViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 01.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: CircleImageView!
    
    @IBOutlet weak var firstnameField: CustomTextField!
    
    @IBOutlet weak var surnameField: CustomTextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var yearField: CustomTextField!
    
    @IBOutlet weak var weightField: CustomTextField!
    
    @IBOutlet weak var closeProfile: UIButton!
    
    let viewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        self.decideTypeOfLaunch()
        
        self.hideKeyboardOnTap()
        
        profileImage.circleImage()
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.profileImageTapped)))
        profileImage.isUserInteractionEnabled = true
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        usernameLabel.text = UserDefaults.standard.value(forKey: Constants.User.USERNAME) as? String
        
        getProfileImage()
        
        getUserInfo()
    }
    
    func getUserInfo() {
        viewModel.retriveUserData()
    }
    
    func getProfileImage() {
        viewModel.retriveProfileImage()
    }
    
    func saveTapped() {
        
        let user = User(firstname: firstnameField.text!, surname: surnameField.text!, gender: "Male", yearOfBirth: yearField.text!, weight: weightField.text!)
        
        viewModel.saveUserProfile(user: user)
        
        //PresentStoryboard.sharedInstance.showGraph(vc: self)
        PresentStoryboard.sharedInstance.showAddFriends(vc: self)
    }
    
    
    func decideTypeOfLaunch() {
        let firstLaunch = UserDefaults.standard.bool(forKey: Constants.UserDef.FIRST_LAUNCH)
        if !firstLaunch {
            print("Not first launch")
            saveButton.setTitle("SAVE", for: .normal)
            closeProfile.addTarget(self, action: #selector(dismissProfile), for: .touchUpInside)
        } else {
            print("First time launch")
            closeProfile.isHidden = true
            UserDefaults.standard.set(false, forKey: Constants.UserDef.FIRST_LAUNCH)
        }
    }
    
    
    func dismissProfile() {
        dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController: ProfileViewModelProtocol {
    
    func setProfileInfo(user: User) {
        DispatchQueue.main.async(execute: {
            UIView.transition(with: self.profileImage, duration: 0.3, options: .transitionCrossDissolve, animations: {
                if let firstname = user.firstname, firstname != "" {
                    self.firstnameField.text = firstname
                }
                if let surname = user.surname, surname != "" {
                    self.surnameField.text = surname
                }
                if let year = user.yearOfBirth, year != "" {
                    self.yearField.text = year
                }
                if let weight = user.weight, weight != "" {
                    self.weightField.text = weight
                }
            }, completion: nil)
        })
    }

    func setProfileImage(image: UIImage) {
        DispatchQueue.main.async(execute: {
            UIView.transition(with: self.profileImage, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.profileImage.image = image
            }, completion: nil)
        })
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
            viewModel.saveProfileImage(image: editedImage)
        } else if let originalPhoto = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            profileImage.image = originalPhoto
            originalPhoto.printMemory()
            viewModel.saveProfileImage(image: originalPhoto)
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
