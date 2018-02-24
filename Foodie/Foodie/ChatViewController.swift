//
//  ChatViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 10..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class ChatViewController: UIViewController {
    @IBOutlet weak var chatTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //database = firebase.database()
        //chat reference
        
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func letsParty(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the party server
        
        
    }
    
    @IBAction func qrcode(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the qrcode
    }
    
}

