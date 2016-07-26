//
//  TravellingMobileDetailsViewController.swift
//  Travelling
//
//  Created by Jatin Verma on 7/24/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftValidator
import Alamofire

class TravellingMobileDetailsViewController: UIViewController,ValidationDelegate {

    @IBOutlet weak var nameTextField: IsaoTextField!
    @IBOutlet weak var emailTexrField: IsaoTextField!
    @IBOutlet weak var mobileNumberTextField: IsaoTextField!
    @IBOutlet weak var pincodeTextField: IsaoTextField!
    @IBOutlet weak var nameErrorTextField: UILabel!
    @IBOutlet weak var emailAddressErrorTextField: UILabel!
    @IBOutlet weak var phoneNumberTextField: UILabel!
    @IBOutlet weak var policy: UILabel!
    let validator = Validator()

    var params = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //For dismiss keyboard when user tabs on view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TravellingMobileDetailsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        validate()
        nameTextField.becomeFirstResponder()
    }
    
    //MARK:- function for checking validation
    func validationSuccessful() {
        params = [
            "name" : nameTextField.text!,
            "email" : emailTexrField.text!,
            "mobile" : mobileNumberTextField.text!,
            "did" : UIDevice.currentDevice().identifierForVendor!.UUIDString,
            "onesignal_id" : 2,
            "fbid" : "232"
        ]
        gettingOTP(params)
        
    }
    func validationFailed(errors:[UITextField:ValidationError]) {
        self.hideHUD()
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
        validator.registerField(nameTextField, errorLabel: nameErrorTextField, rules: [RequiredRule()])
        validator.registerField(emailTexrField, errorLabel: emailAddressErrorTextField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(mobileNumberTextField, errorLabel: phoneNumberTextField, rules: [RequiredRule(),PhoneNumberRule()])
        
    }
    
    //MARK:-Register button click
    @IBAction func registerAllDetailsButtonTapped(sender: UIButton) {
        self.showProgressHUD()
        validator.validate(self)
        

    }
    @IBAction func termsOfUse(sender: UIButton) {
        let alert = UIAlertController(title: "Terms of Use", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func privatePolicy(sender: UIButton) {
        let alert = UIAlertController(title: "Private Policy", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func gettingOTP(parameters:[String:AnyObject]){
        TravellingApiService.request(.POST, url: "/users", params: parameters, encoding: .URL, success: { (json) in
            let otp = json["otp"].string
            NSUserDefaults.standardUserDefaults().setObject(otp, forKey: "otp")
            self.hideHUD()
            let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("TravellingOTPScreenViewController") as! TravellingOTPScreenViewController
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginWithMobile")
            self.navigationController?.pushViewController(nvc, animated: true)
            }) { (error) in
                self.showErrorHUD(error.message)
        }
    
        
        
    }

}
