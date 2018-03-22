//
//  Food.swift
//  Foodie
//
//  Created by Smile. on 21/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import MapKit
class Food: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var name = ""
    var address = ""
    var imageURL = URL.init(string: "")
    var distance = ""
    var ratingImageURL = URL.init(string: "")
    var reviewCount = 0
    var rating = 0.0
    var phone = ""
    var id = ""
    var reviewwritten = ""
//    var coordinate: CLLocationCoordinate2D
//    var location: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
