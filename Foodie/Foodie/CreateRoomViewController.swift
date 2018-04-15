//
//  CreateRoomViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 22..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


class CreateRoomViewController:UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textColorPickerview: UIPickerView!
    
    @IBOutlet weak var backgroundColorPickerview: UIPickerView!
    
    @IBOutlet weak var bubbleColorPickerview: UIPickerView!
    
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var backgroundlabel: UILabel!
    @IBOutlet weak var bubblelabel: UILabel!
    
    let textcolor = ["Black", "White", "Red"]
    let backgroundcolor = ["White", "Yellow"]
    let bubblecolor = ["Red", "Blue", "Green", "Light Gray"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView == textColorPickerview) {
            return textcolor[row]
        }
        else if(pickerView == backgroundColorPickerview) {
            return backgroundcolor[row]
        }
        else {
            return bubblecolor[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(pickerView == textColorPickerview) {
            return textcolor.count
        }
        else if(pickerView == backgroundColorPickerview) {
            return backgroundcolor.count
        }
        else {
            return bubblecolor.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView == textColorPickerview) {
            textlabel.text = textcolor[row]
        }
        else if(pickerView == backgroundColorPickerview) {
            backgroundlabel.text = backgroundcolor[row]
        }
        else {
            bubblelabel.text = bubblecolor[row]
        }
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
