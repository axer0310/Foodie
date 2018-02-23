//
//  ViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/1/30.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import CoreLocation


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate
{
   

    @IBOutlet var logoImage: UIImageView!
    var user = User()
    var ref: DatabaseReference!
    var userLocalInfo = UserDefaults.standard // use to store user id to local
    
//    let locationManager = CLLocationManager()
    
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
        

        if let id = self.userLocalInfo.object(forKey: "id") as? String
        {
            self.user.id = id
//            self.updateSetUserInfo(newUser: false, id: id)
        }
//        else
//        {
//            self.userLocalInfo.set(self.user.id, forKey: "id")
//            self.updateSetUserInfo(newUser: true, id: "")
//        }
        
        
//        self.locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
    {
        print("In google sign in")
        if let error = error
        {
            print("Error: \(error) " )
        }
        else
        {
        
            guard let authentication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential){(user, error) in
                if let error = error
                {
                    print("Error: \(error)")
                    return
                }
                
                if let name = user?.displayName
                {
                    self.user.name = name
                }
                if self.user.id == ""
                {
                    self.user.id = self.randomString(length: 16)
                    self.userLocalInfo.set(self.user.id, forKey: "id")
                }
                if let url = user?.photoURL as? URL
                {
                    do
                    {
                        if let data = try? Data(contentsOf: url)
                        {
                            self.user.profilePic = UIImage(data: data)!
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
                self.user.coordinate = ["x": 43.09, "y": 38.72] // testing data
                self.user.friendList = ["oidfw77ehda332r", "uyrdufaw324ewf"]   // testing data
                
                self.updateSetUserInfo()
                
                self.presentMainView()
            }
        }
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        if let error = error
        {
            print(error.localizedDescription)
            return
        }
        else
        {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                
                if let error = error
                {
                    print(error)
                    return
                }
                if let name = user?.displayName
                {
                    self.user.name = name
                }

                self.presentMainView()
            }
        }
        // ...
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func presentMainView()
    {
        
        if let storyboard =  UIStoryboard(name: "MainPage", bundle: nil) as? UIStoryboard
        {
            if let nav = storyboard.instantiateViewController(withIdentifier: "mainPageNav") as? UINavigationController
            {
                let vc = nav.childViewControllers[0] as? MainPageViewController
                if let vc = vc
                {
                    vc.user = self.user
                }
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func updateSetUserInfo()
    {
        var userInfo = firebaseUserInfo()
        userInfo.CoordinateX = self.user.coordinate["x"]!
        userInfo.CoordinateY = self.user.coordinate["y"]!
        userInfo.FriendList = self.user.friendList
        userInfo.UserId = self.user.id
        
        
        let post = ["Coordinate": ["x" : userInfo.CoordinateX, "y" : userInfo.CoordinateY],
                    "FriendIDs": userInfo.FriendList,
                    ] as [String : Any]
        let childUpdates = ["/Users/\(userInfo.UserId)": post]
        ref.updateChildValues(childUpdates)
        
    }
    
    func randomString(length: Int) -> String {
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

