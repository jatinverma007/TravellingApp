//
//  Demo.swift
//  Travelling
//
//  Created by Jatin Verma on 7/22/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON
class Demo {
    class func fetchAllStories( success: (([NewsStories], totalNews: Int, currentPage: Int, lastPage: Int) -> Void), failure: ((TravellingError) -> Void)) {
        TravellingApiService.request(.GET, url: "/stories", params: nil,encoding: .URL, success: { (json) in
            var newsStories = [NewsStories]()
            
            for (_,subJson):(String,JSON) in json!["data"] {
                newsStories.append(NewsStories(json: subJson))
            }
            let totalNews = json["total"].int
            let currentPage = json["current_page"].int
            let lastPage = json["last_page"].int
            
            success(newsStories, totalNews: totalNews!, currentPage: currentPage!, lastPage: lastPage!)        })
        { (error) in
            failure(error)
        }
    }
}