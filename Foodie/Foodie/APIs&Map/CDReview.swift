//
//  CDReview.swift
//  Foodie
//
//  Created by Smile. on 20/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import ObjectMapper

public class CDReview: Mappable {
    
    public var total: Int?
    public var reviews: [CDYelpReview]?
//    public var error: CDYelpError?
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        total   <- map["total"]
        reviews <- map["reviews"]
//        error   <- map["error"]
    }
}
public class CDYelpReview: Mappable {
    
    public var text: String?
    public var url: URL?
    public var rating: Int?
    public var timeCreated: String?
    public var user: CDYelpUser?
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        text        <- map["text"]
        url         <- (map["url"], URLTransform())
        rating      <- map["rating"]
        timeCreated <- map["time_created"]
        user        <- map["user"]
    }
}

public class CDYelpUser: Mappable {
    
    public var name: String?
    public var imageUrl: URL?
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        name        <- map["name"]
        imageUrl    <- (map["image_url"], URLTransform())
    }
}

