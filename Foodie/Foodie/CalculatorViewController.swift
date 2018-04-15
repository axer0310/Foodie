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
    
    var num: String = ""
    var total: Double = 0.00
    
    @IBOutlet weak var Display: UILabel!
    
    @IBAction func ClearButton(_ sender: Any) {
        Display.text = "0"
    }
    
    @IBAction func BackSpace(_ sender: Any) {
    }
    
    @IBAction func One(_ sender: Any) {
        num += "1"
    }
    
    @IBAction func Two(_ sender: Any) {
        num += "2"
    }
    
    @IBAction func Three(_ sender: Any) {
        num += "3"
    }
    
    @IBAction func Four(_ sender: Any) {
        num += "4"
    }
    
    @IBAction func Five(_ sender: Any) {
        num += "5"
    }
    
    @IBAction func Six(_ sender: Any) {
        num += "6"
    }
    
    @IBAction func Seven(_ sender: Any) {
        num += "7"
    }
    
    @IBAction func Eight(_ sender: Any) {
        num += "8"
    }
    
    @IBAction func Nine(_ sender: Any) {
        num += "9"
    }
    
    @IBAction func Zero(_ sender: Any) {
        num += "0"
    }
    
    @IBAction func Plus(_ sender: Any) {
        num += "+"
    }
    
    @IBAction func Minus(_ sender: Any) {
        num += "-"
    }
    
    @IBAction func Divide(_ sender: Any) {
    }
    
    @IBAction func Multiply(_ sender: Any) {
    }
    
    @IBAction func Equal(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Meal Calculator"
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
