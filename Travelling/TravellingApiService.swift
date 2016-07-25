//
//  TravellingApiService.swift
//
//  Created by Jatin Verma on 7/4/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import ReachabilitySwift
import SwiftyJSON
import Alamofire

class TravellingApiService {
    
    static var alamofireManager: Manager?
    
    class func reachabilityError() -> TravellingError {
        return TravellingError(statusCode: 0, message: TravellingConstants.ErrorStrings.reachabilityError)
    }
    
    class func isReachable() -> Bool {
        do {
            let reachability = try Reachability(hostname: TravellingConstants.Services.News.baseURL)
            if reachability.isReachable() {
                return true
            }
        } catch {
            print("Unable to set Reachability")
        }
        return false
    }
    
    class func request(method: Alamofire.Method, url: String, params: [String: AnyObject]?, encoding: Alamofire.ParameterEncoding = .URL,success: ((JSON!) -> Void)?, failure: ((TravellingError) -> Void)?) {
        
        if TravellingApiService.isReachable() {
            let absoluteURL = TravellingConstants.Services.News.baseURL + url
            if alamofireManager == nil {
                let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
                alamofireManager = Alamofire.Manager(configuration: configuration)
            }
            
            
            alamofireManager?.request(method, absoluteURL, parameters: params,encoding: encoding).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .Success :
                    if let result = response.result.value {
                        let json = JSON(result)
                        success?(json)
                    }
                case .Failure:
                    if response.response?.statusCode >= 200 && response.response?.statusCode < 300  {
                        success?(nil)
                    } else {
                        let jsonString = NSString(data: response.data!, encoding: NSUTF8StringEncoding) as! String
                        let json = JSON.parse(jsonString)
                        let error = TravellingError(json: json)
                        failure?(error)
                    }
                }
            })
        }
        else {
            failure!(TravellingError(statusCode: 1, message: "Internet Connection Unavailable"))
        }
    }
    
}