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
    public var error: CDYelpError?
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        total   <- map["total"]
        reviews <- map["reviews"]
        error   <- map["error"]
    }
}
