//
//  CalculatorViewController.swift
//  Foodie
//
//  Created by Samrat  on 4/14/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase


class CalculatorViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Meal Calculator"
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
