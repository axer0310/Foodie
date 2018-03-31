//
//  TipCalculatorViewController.swift
//  Foodie
//
//  Created by Samrat  on 3/30/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase


class TipCalculatorViewController: UIViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tip Calculator"
}
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
