//
//  RestaurantAnnotation.swift
//  Foodie
//
//  Created by Arthur on 2018/3/21.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import MapKit

class RestaurantAnnotation:MKPointAnnotation
{
    var name = ""
    var address = ""
    var imageURL =  URL.init(string: "")
    var categories = ""
    var distance = ""
    var ratingImageURL = URL.init(string: "")
    var reviewCount = NSNumber.init()
    var rating = 0.0
    var phone = ""
    var id = ""
    var reviewwritten = ""
}
