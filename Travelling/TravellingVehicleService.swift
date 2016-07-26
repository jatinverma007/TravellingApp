//
//  TravellingVehicleService.swift
//  Travelling
//
//  Created by Jatin Verma on 7/26/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class TravellingVehicleService {
    
    //MARK:-Fetch All Vehicles
    class func fetchAllVehicles(params:[String:AnyObject]? , success: (([TravellingVehicles]) -> Void), failure: ((TravellingError) -> Void)) {
        TravellingApiService.request(.POST, url: "/cab/products", params: params,encoding: .URL, success: { (json) in
            var travellingVehicles = [TravellingVehicles]()
            
            for (_,subJson):(String,JSON) in json![0] {
                print(json[0])
                travellingVehicles.append(TravellingVehicles(json: subJson))
            }
            
            success(travellingVehicles)        })
        { (error) in
            failure(error)
        }
    }
    
    
}

