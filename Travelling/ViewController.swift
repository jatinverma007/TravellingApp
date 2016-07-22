//
//  ViewController.swift
//  Travelling
//
//  Created by Jatin Verma on 7/21/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    //MARK:-ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        facebookLoginButton.delegate = self        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if ((FBSDKAccessToken.currentAccessToken() != nil) || (GIDSignIn.sharedInstance().hasAuthInKeychain())) {
            loginInSuccessfully()
        }
    }
    
    //MARK:-Facebook SignIn Delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            print(error.localizedDescription)
        }
        if result.token != nil {
            loginInSuccessfully()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        
    }
    
    //MARK:- GoogleSignIn Delegate
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
        loginInSuccessfully()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
       
    }

    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK:- Function for Pushing to LoggedInViewController
    func loginInSuccessfully(){
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoggedInViewController") as! LoggedInViewController
        let navVC = UINavigationController(rootViewController: loginVC)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = navVC

    }

}

