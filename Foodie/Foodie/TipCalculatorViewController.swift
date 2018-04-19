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
    
    var num: String = ""
    var total: Double = 0.00
    var tip1: Double = 1.15
    var tip2: Double = 1.20
    var custom_tip: UITextField?
    
    

    @IBOutlet weak var Tip: UILabel!
    
    @IBOutlet weak var Button_One: UIButton!
    
    @IBAction func Button_One(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "1"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Two: UIButton!

    @IBAction func Button_Two(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "2"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Three: UIButton!
    
    @IBAction func Button_Three(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "3"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Four: UIButton!
    
    @IBAction func Button_Four(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "4"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Five: UIButton!
    @IBAction func Button_Five(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "5"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Six: UIButton!
    @IBAction func Button_Six(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "6"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Seven: UIButton!
    @IBAction func Button_Seven(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "7"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Eight: UIButton!
    @IBAction func Button_Eight(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "8"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Nine: UIButton!
    @IBAction func Button_Nine(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "9"
        Tip.text = num
    }
    
    @IBOutlet weak var Button_Zero: UIButton!
    @IBAction func Button_Zero(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        num += "0"
        Tip.text = num
    }
    
    @IBOutlet weak var Dot: UIButton!
    @IBAction func Dot(_ sender: Any) {
        if (num == "0") {
            num = ""
        }
        if (!num.contains(".")) {
        num += "."
        }
        Tip.text = num
    }
    
    @IBOutlet weak var Backspace: UIButton!
    @IBAction func Backspace(_ sender: Any) {
        if (num == "") {
            num = "0"
        }
        if (num.count > 0) {
            num = String(num.prefix(num.count - 1))
            if (num.count == 0) {
                num = "0"
            }
        }
        Tip.text = num
    }
    
    func alertMessage(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated:true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var Tip1: UIButton!
    @IBAction func Tip1(_ sender: Any) {
        
        if (Tip.text == "0") {
                    alertMessage(title: "Error", message: "Please Enter a Number First")
        } else {
            if (Tip.text?.last! == ".") {
                Tip.text? += "0"
            }
            total = Double(Tip.text!)!
            total *= tip1
            total = (total * 100).rounded()/100
            Tip.text = String(total)
            num = "0"
        }
    }
    
    @IBOutlet weak var Tip2: UIButton!

    @IBAction func Tip2(_ sender: Any) {
        if (Tip.text == "0") {
            alertMessage(title: "Error", message: "Please Enter a Number First")
        } else {
            if (Tip.text?.last! == ".") {
                Tip.text? += "0"
            }
            total = Double(Tip.text!)!
            total *= tip2
            total = (total * 100).rounded()/100
            Tip.text = String(total)
            num = "0"
        }
    }
    
    
    @IBOutlet weak var Custom_Tip: UIButton!

    @IBAction func Custom_Tip(_ sender: Any) {
            displayPrompt(title: "Custom Tip", message: "Enter your custom tip")
    }
    
    func displayPrompt(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: custom_tip)
        
        let tipOne = UIAlertAction(title: "Tip 1", style: .default, handler: self.tipOneHandler)
        
        let tipTwo = UIAlertAction(title: "Tip 2", style: .default, handler: self.tipTwoHandler)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(tipOne)
        alert.addAction(tipTwo)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
    }
    
    func alphabetCheck(input: String) -> Bool {
        for chr in input {
            if (chr == "%") {
                continue
            }
            if ((chr >= "a" && chr <= "z" ) || (chr >= "A" && chr <= "Z") || (!(chr >= "0" && chr <= "9"))) {
                return false
            }
        }
        return true
    }
    
    func percentageChecker(input: String) -> Bool {
        var counter: Int = 0
        for chr in input {
            if (chr == "%") {
                counter = counter + 1
            }
            if (counter == 2) {
                return true
            }
        }
        return false
    }
    
    func tipOneHandler(alert: UIAlertAction!) {
        var temp: String = (custom_tip?.text)!
        
        if (!temp.contains("%") && temp != "") {
            displayPrompt(title: "Error", message: "Your custom tip must contain the sybmbol \"%\"")
        } else if (temp == "") {
            displayPrompt(title: "Error", message: "Please enter your custom tip")
        } else if (temp.contains("-")) {
            displayPrompt(title: "Error", message: "Tips cannot be negative")
        } else if (!alphabetCheck(input: temp)){
            displayPrompt(title: "Error", message: "Your custom tip cannot contain alphabets or non-numeric characters")
        } else if (temp == "%") {
            displayPrompt(title: "Error", message: "Your custom tip must contain numbers before the \"%\" sign")
        } else if (percentageChecker(input: temp)){
            displayPrompt(title: "Error", message: "Tips must be in the format \"<number>%\"")
        } else {
        
        Tip1.setTitle(custom_tip?.text, for: .normal)
        
        temp = String(temp.prefix(temp.count - 1))
        
        tip1 = Double(temp)!
        
        tip1 = (tip1/100) + 1
        }
        
    }
    
    func tipTwoHandler(alert: UIAlertAction!) {
        var temp2: String = (custom_tip?.text)!
        
        if (!temp2.contains("%") && temp2 != "") {
            displayPrompt(title: "Error", message: "Your custom tip must contain the sybmbol \"%\"")
        } else if (temp2 == "") {
            displayPrompt(title: "Error", message: "Please enter your custom tip")
        } else if (temp2.contains("-")) {
            displayPrompt(title: "Error", message: "Tips cannot be negative")
        } else if (!alphabetCheck(input: temp2)){
            displayPrompt(title: "Error", message: "Your custom tip cannot contain alphabets")
        } else if (temp2 == "%") {
            displayPrompt(title: "Error", message: "Your custom tip must contain numbers before the \"%\" sign")
        } else if (percentageChecker(input: temp2)){
            displayPrompt(title: "Error", message: "Tips must be in the format \"<number>%\"")
        } else {
            
        Tip2.setTitle(custom_tip?.text, for: .normal)
        
        temp2 = String(temp2.prefix(temp2.count - 1))
        
        tip2 = Double(temp2)!
        
        tip2 = (tip2/100) + 1
        }
    }
    
    func custom_tip(textField: UITextField!) {
        custom_tip = textField
        custom_tip?.placeholder = "Enter custom tip"
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tip Calculator"
}
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

