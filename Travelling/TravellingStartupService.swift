//
//  TravellingStartupService.swift
//  Travelling
//
//  Created by Jatin Verma on 7/24/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class TravellingStartupService {
    
//    class func getPhoneDetails(params: [String:AnyObject], success: (Void) , failure: (TravellingError) -> Void){
//
//        TravellingApiService.request(.POST, url: "locations", params: params, success: { (json) in
//        print(json)
//        }) { (error) in
//                failure(error)
//        }
//    }
    
    class func getCabDetails(params: [String:AnyObject], success : (JSON) -> JSON , failure : (TravellingError) -> Void ){
        
        TravellingApiService.request(.POST, url: "products", params: params, encoding: .URL, success: { (json) in
            print(json)
            }) { (error) in
                failure(error)
        }
    }
}