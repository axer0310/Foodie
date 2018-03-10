//
//  MainPartyViewController.swift
//  Foodie
//
//  Created by Samrat  on 3/8/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class MainPartyViewController: UIViewController
{

    var ref: DatabaseReference!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        self.navigationItem.title = "Parties List"
    }
    
    

}
