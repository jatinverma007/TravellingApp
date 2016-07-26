//
//  UIViewController+Codekamp.swift
//  CKContact
//
//  Created by Piyush Mishra on 10/05/16.
//  Copyright © 2016 Codekamp. All rights reserved.
//

import Foundation
import PKHUD

extension UIViewController {
    
    func showProgressHUD() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    func showSuccessHUD() {
        PKHUD.sharedHUD.contentView = PKHUDSuccessView()
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 1.0)
    }
    
    func showErrorHUD(error:String, duration:NSTimeInterval = 2.0) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: error)
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: duration)
    }
    
    func hideHUD() {
        PKHUD.sharedHUD.hide(animated: true, completion: nil)
    }
    
    func showTextHUD(message:String, duration:NSTimeInterval = 2.0) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: message)
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: duration)
    }
   

    
}
