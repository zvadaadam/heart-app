//
//  AddFriendViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 07.08.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userSearch: UISearchBar!
    
    var viewModel: AddFriendsViewModel = AddFriendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        
        viewModel.delegate = self
        userSearch.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
    }

    
    @IBAction func closeTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showGraph(vc: self)
    }

    
}

extension AddFriendViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Change")
        self.viewModel.searchUser(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("result")
        if let searchText = searchBar.text, searchBar.text != "" {
            viewModel.searchUser(name: searchText)
        }
    }
}


extension AddFriendViewController: AddFriendsViewModelDelegate {
    
    func setProfileInfo(image: UIImage) {
        
    }

    
    func searchedUser(user: [User]) {
        tableView.reloadData()
    }
    
    

}


extension AddFriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendsCell", for: indexPath) as? AddFriendsCell else {
            fatalError("Invalid cell class")
        }
        
        //TODO: check wheter is already friend 
        cell.addButton.isSelected = false
        
        UserHandler.sharedInstance.loadProfileImageWithUser(user: viewModel.users[indexPath.row]) { (image) in
            DispatchQueue.main.async(execute: {
                UIView.transition(with: cell.profileImage, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    cell.profileImage.image = image
                }, completion: nil)
            })
        }
        
        cell.profileImage.circleImage()
        
        cell.addButton.addTarget(self, action: #selector(AddFriendViewController.cellButtonPressed(_:)), for: .touchUpInside)
        
        cell.addButton.tag = indexPath.row
        
        cell.nameLabel.text = viewModel.users[indexPath.row].username
        
        //TODO: profile image
        //cell.profileImage = viewModel.users[indexPath.row].profileImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    
    func cellButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        print(viewModel.users[button.tag])
        
        if button.isSelected {
            viewModel.removeFriend(FID: viewModel.users[button.tag].uid!)
            
            UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve, animations: {
                button.setImage(UIImage(named: "icPlus"), for: .normal)
            }, completion: nil)
            
            button.isSelected = false
        } else {
            viewModel.addFriend(FID: viewModel.users[button.tag].uid!)
            
            UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve, animations: {
                button.setImage(UIImage(named: "icTick"), for: .normal)
            }, completion: nil)
            
            button.isSelected = true
        }
    }
    
}

extension AddFriendViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
    }
}

