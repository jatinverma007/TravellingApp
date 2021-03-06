//
//  ViewController.swift
//  Travelling
//
//  Created by Jatin Verma on 7/21/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import CoreLocation


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var mobileSignIn: UIButton!
    let LocationManager = CLLocationManager()
    //var travellingVehicles:[TravellingVehicles]?

    //MARK:-ViewController Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        facebookLoginButton.readPermissions = ["email"]
//        let params = ["lat" : 28.6294,
//                      "long" : 77.4329,
//                      "cat" : "cab"]
//        TravellingVehicleService.fetchAllVehicles(params,success: { (vehicles) in
//            self.travellingVehicles?.appendContentsOf(vehicles)
//        }) { (error) in
//            print(error) 
//            
//        }

      

        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        mobileSignIn.layer.borderWidth = 0.8
        mobileSignIn.layer.borderColor = UIColor.whiteColor().CGColor
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        facebookLoginButton.delegate = self        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
                getLocationAccess()
        if ((FBSDKAccessToken.currentAccessToken() != nil) || (GIDSignIn.sharedInstance().hasAuthInKeychain()) || (NSUserDefaults.standardUserDefaults().boolForKey("loginWithMobile"))) {
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            let navVC = UINavigationController(rootViewController: loginVC)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = navVC
        }
    }
    
    //MARK:-Facebook SignIn Delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            print(error.localizedDescription)
        }
        if result.token != nil {
            let params = ["fields" : "email, first_name, last_name, picture"]
            FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler { (connection, result, error) in
                let firstName = result["first_name"] as! String
                let lastName = result["last_name"] as! String
                let name = firstName + " " + lastName
                let fbid = result["id"] as! String
                NSUserDefaults.standardUserDefaults().setObject("032abes459@gmail.com", forKey: "email")
                
                self.saveToUserDefaults(name, profilePic: result["picture"]!!["data"]!!["url"] as! String, id: fbid)
            }

            loginInSuccessfully()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        
    }
    
    //MARK:- GoogleSignIn Delegate
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let imageURL = user.profile.imageURLWithDimension(50)
            let email = user.profile.email
            NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email")
            let idToken = user.authentication.idToken
            saveToUserDefaults(user.profile.givenName, profilePic: String(imageURL), id: idToken)
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
    
    func saveToUserDefaults(username:String, profilePic:String, id:String){
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
        NSUserDefaults.standardUserDefaults().setObject(profilePic, forKey: "profilepic")
        NSUserDefaults.standardUserDefaults().setObject(id, forKey: "id")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }

    @IBAction func goToMobileScreen(sender: UIButton) {
        let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("TravellingMobileDetailsViewController") as! TravellingMobileDetailsViewController
        self.navigationController?.pushViewController(nvc, animated: true)
    }
    
    
    //MARK:- Location Delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.showTextHUD("Getting Location")
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                self.showTextHUD("Cannot find location")
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                NSUserDefaults.standardUserDefaults().setObject(pm.locality, forKey: "current_location")
                self.hideHUD()
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        NSUserDefaults.standardUserDefaults().setObject(locValue.latitude, forKey: "latitude")
        NSUserDefaults.standardUserDefaults().setObject(locValue.longitude, forKey: "longitude")
        NSUserDefaults.standardUserDefaults().synchronize()
        LocationManager.stopUpdatingLocation()
    }
    
    
    func getLocationAccess(){
        if (CLLocationManager.locationServicesEnabled())
        {
            LocationManager.delegate = self
            LocationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationManager.requestAlwaysAuthorization()
            LocationManager.startUpdatingLocation()
        }
        
    }

}

