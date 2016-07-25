//
//  NewsStories.swift
//  Travelling
//
//  Created by Jatin Verma on 7/22/16.
//  Copyright © 2016 Jatin Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsStories {
    var id:Int?
    var title:String?
    var description:String?
    var article_link:String?
    var thumbnail_url:String?
    var created_at:String?
    var short_url:String?
    init(json: JSON) {
        self.id = json["id"].int
        self.title = json["title"].string
        self.description = json["description"].string
        self.article_link = json["article_link"].string
        self.thumbnail_url = json["thumbnail_url"].string
        self.created_at = json["created_at"].string
        self.short_url = json["short_url"].string
    }
    
}
