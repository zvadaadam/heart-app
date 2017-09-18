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

        viewModel.delegate = self
    }

    
    @IBAction func closeTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showGraph(vc: self)
    }

    
}


extension AddFriendViewController: AddFriendsViewModelDelegate {
    
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
            button.setImage(UIImage(contentsOfFile: "icPlus"), for: .normal)
            button.isSelected = false
        } else {
            button.setImage(UIImage(contentsOfFile: "icCheck"), for: .normal)
            button.isSelected = true
        }
    }
    
}

extension AddFriendViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
    }
}

