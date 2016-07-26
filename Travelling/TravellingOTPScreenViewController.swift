//
//  TravellingOTPScreenViewController.swift
//  Travelling
//
//  Created by Jatin Verma on 7/25/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire

class TravellingOTPScreenViewController: UIViewController {

    @IBOutlet weak var enterOTPButton: UIButton!
    @IBOutlet weak var otpTextField: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpTextField.becomeFirstResponder()
        self.enterOTPButton.backgroundColor = UIColor.blueColor()
        self.enterOTPButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }

    @IBAction func verifyOTP(sender: UIButton) {
        
//        var params = [String:AnyObject]()
////        params = [
////            "did" : UIDevice.currentDevice().identifierForVendor!.UUIDString,
////            "mobile" : "9868101211",
////            "val_at" : "1469532728"
////        ]
////        Alamofire.request(.POST, "http://staging.app-api.dride.in/api/v1/verify", parameters: params)
////            .responseJSON { response in
////                if let JSON = response.result.value {
////                    print("JSON: \(JSON)")
////                }
////        }
//        
//        TravellingApiService.request(.POST, url: "/verify", params: params, encoding: .URL, success: <#T##((JSON!) -> Void)?##((JSON!) -> Void)?##(JSON!) -> Void#>, failure: <#T##((TravellingError) -> Void)?##((TravellingError) -> Void)?##(TravellingError) -> Void#>)
        print(otpTextField.text)
        let otp = NSUserDefaults.standardUserDefaults().objectForKey("otp") as! String
        print(otp)
        if otpTextField.text == otp {
            let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(nvc, animated: true, completion: nil)
        }
        else
        {
            self.showTextHUD("OTP Incorrect")
        }
        

    }
   
}
