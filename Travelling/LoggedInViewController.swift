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
import TextFieldEffects
import SwiftValidator
import Alamofire


class LoggedInViewController: UIViewController, GIDSignInUIDelegate,ValidationDelegate {

    @IBOutlet weak var phoneNumberTextField: IsaoTextField!
    @IBOutlet weak var phoneNumberPinCode: IsaoTextField!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var confirmNumberButton: UIButton!
    var params = [String:AnyObject]()
    var systemParam = [String:AnyObject]()


    let validator = Validator()

    //MARK:- ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberTextField.becomeFirstResponder()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //setupLoginButton
        self.confirmNumberButton.backgroundColor = UIColor.blueColor()
        self.confirmNumberButton.layer.cornerRadius = 5
        self.confirmNumberButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.confirmNumberButton.titleEdgeInsets = UIEdgeInsetsMake(0, -1, 0, -1)
        self.phoneNumberTextField.placeholder = "Enter Mobile Number"
        validate()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    
    @IBAction func ConfirmPhoneNumberButtonTapped(sender: UIButton) {
        validator.validate(self)
     

    }
    @IBAction func backToLoginScreen(sender: UIBarButtonItem) {
        GIDSignIn.sharedInstance().signOut()
        let logOut = FBSDKLoginManager()
        logOut.logOut()
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        let loginNavVC = UINavigationController(rootViewController: loginVC)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNavVC
    }
    //MARK:- LogOutButton Tapped
    @IBAction func logoutButtonTapped(sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let logOut = FBSDKLoginManager()
        logOut.logOut()
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        let loginNavVC = UINavigationController(rootViewController: loginVC)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNavVC
    }
    //MARK:- function for checking validation
    func validationSuccessful() {
        params = [
            "name" : NSUserDefaults.standardUserDefaults().objectForKey("username")!,
            "email" : NSUserDefaults.standardUserDefaults().objectForKey("email")!,
            "mobile" : phoneNumberTextField.text!,
            "did" : UIDevice.currentDevice().identifierForVendor!.UUIDString,
            "onesignal_id" : 2,
            "gid" : NSUserDefaults.standardUserDefaults().objectForKey("id")!,
            "fbid" : NSUserDefaults.standardUserDefaults().objectForKey("id")!
        ]

        gettingSystemInformation()
        gettingOTP(params)
          }
    func validationFailed(errors:[UITextField:ValidationError]) {
    }

    func validate(){
        validator.styleTransformers(success:{ (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            }, error:{ (validationError) -> Void in
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
        })
   validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [PhoneNumberRule()])

    }
       
    func gettingSystemInformation(){
        let deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let batteryLevel = UIDevice.currentDevice().batteryLevel
        let systemVersion = UIDevice.currentDevice().batteryLevel
        let latitude = NSUserDefaults.standardUserDefaults().objectForKey("latitude")!
        let longitude = NSUserDefaults.standardUserDefaults().objectForKey("longitude")!
        systemParam = [
            "did" : deviceId,
            "imei" : "",
            "lat" : latitude,
            "long" : longitude,
            "os" : systemVersion,
            "bat" : batteryLevel
        ]
        TravellingApiService.request(.POST, url: "/locations", params: systemParam, encoding: .URL, success: { (json) in
            print(json)
            }) { (error) in
                self.showErrorHUD(error.message)
        }
       
        
    }
    
    
        func gettingOTP(parameters:[String:AnyObject]){
            TravellingApiService.request(.POST, url: "/users", params: parameters, encoding: .URL, success: { (json) in
                let otp = json["otp"].string
                NSUserDefaults.standardUserDefaults().setObject(otp, forKey: "otp")
                let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("TravellingOTPScreenViewController") as! TravellingOTPScreenViewController
                self.navigationController?.pushViewController(nvc, animated: true)
            }) { (error) in
                self.showErrorHUD(error.message)
            }
    }
}
