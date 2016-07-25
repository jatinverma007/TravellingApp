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
        otpTextField.text = String(NSUserDefaults.standardUserDefaults().objectForKey("otp")!)
        self.enterOTPButton.backgroundColor = UIColor.blueColor()
        self.enterOTPButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }

    @IBAction func verifyOTP(sender: UIButton) {
        
//        var params = [String:AnyObject]()
//        params = [
//            "did" : deviceId,
//            "mobile" : 9868101211
//        ]
//        Alamofire.request(.POST, "http://staging.app-api.dride.in/api/v1/verify", parameters: params)
//            .responseJSON { response in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
        
        let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
        self.navigationController?.pushViewController(nvc, animated: true)

    }
   
}
