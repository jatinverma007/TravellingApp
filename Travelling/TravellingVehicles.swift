//
//  TravellingVehicles.swift
//  Travelling
//
//  Created by Jatin Verma on 7/26/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class TravellingVehicles{
    var display_name:String?
    var minimum:Int?
    var company:String?
    var cost_per_distance:Int?
    var base_fare:Int?
    var cancellation_fee:Int?
    var cost_per_minute:Int?
    var surge_multiplier:Int?
    var ride_estimate_min:Int?
    var ride_estimate_max:Int?
    var eta:Int?
   

    init(json: JSON) {
        self.display_name = json["display_name"].string
        self.minimum = json["minimum"].int
        self.company = json["company"].string
        self.cost_per_distance = json["cost_per_distance"].int
        self.base_fare = json["base_fare"].int
        self.cancellation_fee = json["cancellation_fee"].int
        self.cost_per_minute = json["cost_per_minute"].int
        self.surge_multiplier = json["surge_multiplier"].int
        self.ride_estimate_min = json["ride_estimate_min"].int
        self.ride_estimate_max = json["ride_estimate_max"].int
        self.eta = json["eta"].int
        

    }

}
