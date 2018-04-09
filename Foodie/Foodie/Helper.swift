//
//  Helper.swift
//  Foodie
//
//  Created by Arthur on 2018/2/27.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
class Helper
{
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}

@IBOutlet var logoImage: UIImageView!
var user = User()
var ref: DatabaseReference!
var userLocalInfo = UserDefaults.standard // use to store user id to local

let locationManager = CLLocationManager()
typealias CompletionHandler = () -> Void
@IBOutlet var googleSignButton: GIDSignInButton!

@IBOutlet var fbSignInButton: FBSDKLoginButton!
override func viewDidLoad()
{
    super.viewDidLoad()
    logoImage.image = UIImage(named:"FoodieImage.png" )
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
    fbSignInButton.delegate = self
    self.ref = Database.database().reference()
        
