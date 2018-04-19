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
    var count: Int = 0
    var status: String = ""
    var signs: Array<String> = Array()
    var nums: Array<String> = Array()
    var patterns: Array<String>  = Array()
    
    func alertMessage(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated:true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBOutlet weak var Display: UILabel!
    
    @IBAction func ClearButton(_ sender: Any) {
        num = ""
        Display.text = "0"
    }
    
    @IBAction func BackSpace(_ sender: Any) {
        
        if (patternCheck(str: num)) {
            signs.removeAll()
            nums.removeAll()
            num = "0"
            total = 0.00
        } else {

            if (num == "") {
                num = "0"
            }
            
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                if (num.count > 0) {
                    num = String(num.prefix(num.count - 1))
                    if (num.count == 0) {
                        num = "0"
                    }
                }
            } else {
                num = String(num.prefix(num.count - 1))
            }
            if (num == "") {
                num = "0"
            }
        }
        Display.text = num
        
    }
    
    @IBAction func One(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        
        if (num == "0") {
            num = ""
        }
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        num += "1"
        Display.text = num
    }
    
    @IBAction func Two(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "2"
        Display.text = num
    }
    
    @IBAction func Three(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "3"
        Display.text = num
    }
    
    @IBAction func Four(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "4"
        Display.text = num
    }
    
    @IBAction func Five(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "5"
        Display.text = num
    }
    
    @IBAction func Six(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "6"
        Display.text = num
    }
    
    @IBAction func Seven(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "7"
        Display.text = num
    }
    
    @IBAction func Eight(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "8"
        Display.text = num
    }
    
    @IBAction func Nine(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "9"
        Display.text = num
    }
    
    @IBAction func Zero(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "0") {
            num = ""
        }
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                
                signs.append(String(num.last!))
                
                nums.append(String(num.prefix(num.count - 1)))
                
                num = ""
            }
        }
        
        num += "0"
        Display.text = num
    }
    
    @IBAction func Point(_ sender: Any) {
        if (num == "+" || num == "-" || num == "*" || num == "/" || num == ".") {
            num = ""
        }
        
        if (num == "") {
            signs.removeAll()
            nums.removeAll()
            return
            
        }
        
        if (patternCheck(str: num)) {
            signs.removeAll()
            nums.removeAll()
            return
        }
        
        if (!num.contains(".")) {
            num += "."
        }
        Display.text = num
    }
    
    
    @IBAction func Plus(_ sender: Any) {
        num += "+"
    }
    
    @IBAction func Minus(_ sender: Any) {
        num += "-"
    }
    
    @IBAction func Divide(_ sender: Any) {
        num += "/"
    }
    
    @IBAction func Multiply(_ sender: Any) {
        num += "*"
    }
    
    
    
    
    func patternCheck(str: String) -> Bool {
        var track: Int = 0
        for ch in str {
            var temp: String = ""
            temp = String(ch)
            if (track > 0) {
                if (temp.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) {
                    return true
                } else {
                    track = 0
                }
                continue
            }
            
            if (temp.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) {
                track += 1
            }
        }
        return false
    }
    
    @IBAction func Equal(_ sender: Any) {
        if (num.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) {
            signs.removeAll()
            nums.removeAll()
            num = ""
            total = 0.00
            alertMessage(title: "Error", message: "You must enter numbers along with the operations")
            Display.text = "0"
            return
        }
        
        if (patternCheck(str: num)) {
            signs.removeAll()
            nums.removeAll()
            num = ""
            total = 0.00
            alertMessage(title: "Error", message: "The values you dial in must contain only one sign between each number")
            Display.text = "0"
            return
        }
        
        
        
        
        if (num != "") {
            if (num.last! == "+" || num.last! == "-" || num.last! == "*" || num.last! == "/" ) {
                num = String(num.prefix(num.count - 1))
                Display.text = num
                num = ""
                signs.removeAll()
                nums.removeAll()
                total = 0.00
                alertMessage(title: "Error", message: "Missing number after operator, Re-enter!")
                Display.text = "0"
                return
            }
        }
        
        nums.append(num)
        
        if (nums.count == 0) {
            signs.removeAll()
            nums.removeAll()
            total = 0.00
            num = ""
            alertMessage(title: "Error", message: "Please enter some number to which you want operations to be applied")
            Display.text = "0"
            return
        }
        

        
        if (nums.count == 1) {
            Display.text = String(nums[0])
            total = 0.00
            num = ""
            signs.removeAll()
            nums.removeAll()
            return
        }
        
        
        total = Double(nums[0])!
        nums.remove(at: 0)
        if (signs[0] == "+") {
            total += Double(nums[0])!
            nums.remove(at: 0)
            signs.remove(at: 0)
            
        } else if (signs[0] == "-") {
            total -= Double(nums[0])!
            nums.remove(at: 0)
            signs.remove(at: 0)
            
        } else if (signs[0] == "*") {
            total *= Double(nums[0])!
            nums.remove(at: 0)
            signs.remove(at: 0)
            
        } else if (signs[0] == "/") {
            total /= Double(nums[0])!
            nums.remove(at: 0)
            signs.remove(at: 0)
        }
        
        
        for val in signs {
            count = 0
            for val2 in nums {
                if (count == 1) {
                    break
                }
                
                if (val == "+") {
                    total += Double(val2)!
                    nums.remove(at: 0)
                } else if (val == "-") {
                    total -= Double(val2)!
                    nums.remove(at: 0)
                } else if (val == "*") {
                    total *= Double(val2)!
                    nums.remove(at: 0)
                } else if (val == "/") {
                    total /= Double(val2)!
                    nums.remove(at: 0)
                }
                count += 1
            }
        }
        
        signs.removeAll()
        nums.removeAll()
        
        total = (total * 100).rounded()/100
        
        Display.text = String(total)
        total = 0.00
        num = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Meal Calculator"
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
