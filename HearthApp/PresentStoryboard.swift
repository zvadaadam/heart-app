//
//  PresentStoryboard.swift
//  HearthApp
//
//  Created by Adam Zvada on 03.09.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class PresentStoryboard {
    
    static let sharedInstance = PresentStoryboard()
    
    func showAddFriends(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.ADD_FRIENDS, vcName: Constants.Controllers.ADD_FRIENDS), animated: true, completion: nil)
    }
    
    func showGraph(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.GRAPH, vcName: Constants.Controllers.GRAPH), animated: true, completion: nil)
    }
    
    func showSelectFriends(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.SELECT_FRIENDS, vcName: Constants.Controllers.SELECT_FRIENDS), animated: true, completion: nil)
    }
    
    func showSignUp(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.SIGN_UP, vcName: Constants.Controllers.SIGN_UP), animated: true, completion: nil)
    }
    
    func showSignIn(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.LOGIN, vcName: Constants.Controllers.LOGIN), animated: true, completion: nil)
    }
    
    func showProfile(vc: UIViewController) {
        vc.present(getVC(storyboardName: Constants.Storyboards.PROFILE, vcName: Constants.Controllers.PROFILE), animated: true, completion: nil)
    }
    
    func getVC(storyboardName: String, vcName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcName)
        return vc
    }
}
