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


class LoginViewController: UIViewController, GIDSignInUIDelegate
{

    
    @IBOutlet var signButton: GIDSignInButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: Any)
    {
        GIDSignIn.sharedInstance().signIn()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

