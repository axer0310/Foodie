//
//  Party.swift
//  Foodie
//
//  Created by Arthur on 2018/2/27.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
struct  firebasePartyInfo{
    var PartyID = Helper.randomString(length: 30)
    var PartyName = ""
    var Description = ""
    var CoordinateX = Double()
    var CoordinateY = Double()
    var Members = [""]
    var Carpool = false
    var memberLimit = 40    // Default set max limit to 40 ppl
    
}

class Party {
    var PartyID = Helper.randomString(length: 30)
    var PartyName = ""
    var Description = ""
    var CoordinateX = Double()
    var CoordinateY = Double()
    var Members = [""]
    var Carpool = false
    var memberLimit = 40    // Default set max limit to 40 ppl
}
