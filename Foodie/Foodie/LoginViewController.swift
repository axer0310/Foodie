//
//  ViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/1/30.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import CoreLocation
import Firebase

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate
{
    
    
   

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
        
      

        if let id = self.userLocalInfo.object(forKey: "id") as? String
        {
            self.user.id = id
//            self.updateSetUserInfo(newUser: false, id: id)
        }
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined)
        {
            locationManager.requestWhenInUseAuthorization()
        }
        

    }
    func authLocation(completion: CompletionHandler)
    {
       if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            self.user.coordinate = ["x":(locationManager.location?.coordinate.latitude)!, "y": (locationManager.location?.coordinate.longitude)!]
            completion()
        }
        else
        {
            var alert = UIAlertView()
            alert.title = "Unable to Locate"
            alert.message = "Please enable location service in privacy settings."
            alert.addButton(withTitle: "OK")
            alert.show()
        }
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
            
            if let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken) as? AuthCredential
            {
                self.authLocation(completion: {
                    self.createUserInfo(credential: credential)
                    self.presentMainView()
                    
                })
                
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
            if let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString) as? AuthCredential
            {
                self.authLocation(completion: {
                    self.createUserInfo(credential: credential)
                    self.presentMainView()
                    
                })
            }
            
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func logOut()
    {
        self.userLocalInfo.removeObject(forKey: "id")
        let childUpdates = ["/Users/\(user.id)": nil] as [String : Any?]
        ref.updateChildValues(childUpdates)
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
                    vc.loginEntry = self
                }
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    func createUserInfo(credential: AuthCredential)
    {
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
            else
            {
                self.user.name = "This Usser did not set name."
            }
            if self.user.id == ""
            {
                self.user.id = Helper.randomString(length: 16)
                self.userLocalInfo.set(self.user.id, forKey: "id")
            }
            if let url = user?.photoURL as? URL
            {
                self.user.profilePicUrlStr = url.absoluteString
//                do
//                {
//                    if let data = try? Data(contentsOf: url)
//                    {
//                        self.user.profilePic = UIImage(data: data)!
//                    }
//                }
//                catch
//                {
//                    print(error)
//                }
            }
            //                self.user.coordinate = ["x": 43.09, "y": 38.72] // testing data
            self.user.friendList = ["oidfw77ehda332r", "uyrdufaw324ewf"]   // testing data
            self.updateSetUserInfo()
        }
    }
    func updateSetUserInfo()
    {
        var userInfo = firebaseUserInfo()
        userInfo.CoordinateX = self.user.coordinate["x"]!
        userInfo.CoordinateY = self.user.coordinate["y"]!
        userInfo.FriendList = self.user.friendList
        userInfo.UserId = self.user.id
        userInfo.profilePicURL = self.user.profilePicUrlStr
        userInfo.name = self.user.name
        
        
        let post = ["Coordinate": ["x" : userInfo.CoordinateX, "y" : userInfo.CoordinateY],
                    "FriendIDs": userInfo.FriendList,
                    "ProfilePic": userInfo.profilePicURL,
                    "Name": userInfo.name
                    ] as [String : Any]
        let childUpdates = ["/Users/\(userInfo.UserId)": post]
        ref.updateChildValues(childUpdates)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

