//
//  TravellingError.swift
//  Travelling
//
//  Created by Jatin Verma on 7/22/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class TravellingError {
    var statusCode:Int!
    var message:String!
    
    init(json: JSON) {
        self.statusCode = json["status_code"].int!
        self.message = json["message"].string!
    }
    
    init(statusCode:Int, message:String) {
        self.statusCode = statusCode
        self.message = message
    }
}