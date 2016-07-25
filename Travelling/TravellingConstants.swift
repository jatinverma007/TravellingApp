//
//  TravellingConstants.swift
//  Travelling
//
//  Created by Jatin Verma on 7/22/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

struct TravellingConstants {
    // MARK: Services
    struct Services {
        struct News {
            static let server = " staging.app-api.dride.in/api/v1/"
            static let baseURL = "http://" + TravellingConstants.Services.News.server
        }
    }
    
    //MARK:-Error
    struct ErrorStrings {
        static let internalError = "Internal Error Occurred"
        static let reachabilityError = "Internet not available"
    }
    
    
}