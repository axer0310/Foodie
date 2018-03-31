//
//  User.swift
//  Foodie
//
//  Created by Arthur on 2018/2/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class User
{
    var name : String
    var gender : String
    var id : String
    var profilePicUrlStr: String
    var coordinate: [String:Double]
    var friendList: [String]
    init()
    {
        name = ""
        gender=""
        id = ""
        profilePicUrlStr = ""
        coordinate = ["x":Double(),"y":Double()]
        friendList = []
    }
}
struct  firebaseUserInfo{
    var CoordinateX = Double()
    var CoordinateY = Double()
    var FriendList = [""]
    var UserId = ""
    var profilePicURL=""
    var name = ""
    
    var restaurantLocations = [""]
}
