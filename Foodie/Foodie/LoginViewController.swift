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


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate
{
   

    var user = User()
    
    @IBOutlet var googleSignButton: GIDSignInButton!
    
    @IBOutlet var fbSignInButton: FBSDKLoginButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        fbSignInButton.delegate = self

        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

