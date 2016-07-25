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


    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TravellingMobileDetailsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        validate()
        nameTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }

    //MARK:- function for checking validation
    func validationSuccessful() {
        gettingOTP()
        let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("TravellingOTPScreenViewController") as! TravellingOTPScreenViewController
        self.navigationController?.pushViewController(nvc, animated: true)
        
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
        validator.registerField(nameTextField, errorLabel: nameErrorTextField, rules: [RequiredRule()])
        validator.registerField(emailTexrField, errorLabel: emailAddressErrorTextField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(mobileNumberTextField, errorLabel: phoneNumberTextField, rules: [RequiredRule(),PhoneNumberRule()])
        
    }
    
    @IBAction func registerAllDetailsButtonTapped(sender: UIButton) {
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
    func gettingOTP(){
        var params = [String:AnyObject]()
        params = [
            "name" : "jatin",
            "email" : "jatin.v1997@gmail.com",
            "mobile" : mobileNumberTextField.text!,
            "did" : UIDevice.currentDevice().identifierForVendor!.UUIDString,
            "onesignal_id" : 2,
            "fbid" : "324242"
        ]
        Alamofire.request(.POST, "http://staging.app-api.dride.in/api/v1/users", parameters: params)
            .responseJSON { response in
                               if let JSON = response.result.value {
                    
                    let otp = JSON["otp"]
                    NSUserDefaults.standardUserDefaults().setObject(otp!, forKey: "otp")
                    let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("TravellingOTPScreenViewController") as! TravellingOTPScreenViewController
                    self.navigationController?.pushViewController(nvc, animated: true)
                    
                }
        }
        
        
    }

}
