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
    
    @IBOutlet var subview: UIView!
    
    @IBOutlet weak var textColorPickerview: UIPickerView!
    
    @IBOutlet weak var backgroundColorPickerview: UIPickerView!
    
    @IBOutlet weak var bubbleColorPickerview: UIPickerView!
    
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var backgroundlabel: UILabel!
    @IBOutlet weak var bubblelabel: UILabel!
    
    let textcolorList = ["White", "Black", "Blue", "Brown", "Cyan", "Dark Gray", "Red"]
    let backgroundcolorList = ["White", "Black", "Blue", "Brown", "Cyan", "Green", "Yellow"]
    let bubblecolorList = ["Red", "Blue", "Green", "Light Gray"]
    
    var textcolor : String!
    var backgroundcolor : String!
    var bubblecolor : String!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        subview = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.textcolor = setTextColor(str: textcolorList[0])
        self.backgroundcolor = setTextColor(str: backgroundcolorList[0])
        self.bubblecolor = setTextColor(str: bubblecolorList[0])
        
        //self.textcolor = textcolorList[0]
        //self.backgroundcolor = backgroundcolorList[0]
        //self.bubblecolor = bubblecolorList[0]
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView == textColorPickerview) {
            return textcolorList[row]
        }
        else if(pickerView == backgroundColorPickerview) {
            return backgroundcolorList[row]
        }
        else {
            return bubblecolorList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(pickerView == textColorPickerview) {
            return textcolorList.count
        }
        else if(pickerView == backgroundColorPickerview) {
            return backgroundcolorList.count
        }
        else {
            return bubblecolorList.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView == textColorPickerview) {
            setTextColor(str: textcolorList[row])
            UserDefaults.standard.set(textcolorList[row], forKey: "textcolor")
            textlabel.text = textcolorList[row]
        }
        else if(pickerView == backgroundColorPickerview) {
            setBackgroundColor(str: backgroundcolorList[row])
            UserDefaults.standard.set(backgroundcolorList[row], forKey: "backgroundcolor")
            backgroundlabel.text = backgroundcolorList[row]
        }
        else {
            setBubbleColor(str: bubblecolorList[row])
            UserDefaults.standard.set(bubblecolorList[row], forKey: "bubblecolor")
            bubblelabel.text = bubblecolorList[row]
        }
    }
    
    /*
    func getTextColor() -> String {
        return textcolor
    }
    
    func getBackgroundColor() -> String {
        return backgroundcolor
    }
    
    func getBubbleColor() -> String {
        return bubblecolor
    }
    */
    func setTextColor(str : String) -> String {
        textcolor = str
         return textcolor
    }
    
    func setBackgroundColor(str : String) -> String {
        backgroundcolor = str
         return backgroundcolor
    }
    
    func setBubbleColor(str : String ) -> String {
        bubblecolor = str
         return bubblecolor
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
