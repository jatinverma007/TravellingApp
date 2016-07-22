//
//  LoggedInViewController.swift
//  Travelling
//
//  Created by Jatin Verma on 7/22/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoggedInViewController: UIViewController, GIDSignInUIDelegate {

    //MARK:- ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    //MARK:- LogOutButton Tapped
    @IBAction func logoutButtonTapped(sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let logOut = FBSDKLoginManager()
        logOut.logOut()
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let loginNavVC = UINavigationController(rootViewController: loginVC)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNavVC
    }


}
