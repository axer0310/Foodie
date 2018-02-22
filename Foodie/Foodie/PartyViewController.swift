//
//  Party.swift
//  Foodie
//
//  Created by Samrat  on 2/7/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import UIKit
class PartyViewController: UIViewController
{
    var partyName: String = ""
    var location: String = ""
    var info: String = ""
    var numPeople: Int = 0;
    
    @IBAction func NextButton(_ sender: Any) {
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var PartyNameLabel: UILabel!
  
    @IBOutlet weak var PartyName: UITextField!
    
    @IBAction func PartyName(_ sender: Any) {
        partyName = PartyName.text!
    }
    
    
    @IBOutlet weak var Location: UILabel!
    
    @IBOutlet weak var LocationName: UITextField!
    
    @IBAction func LocationName(_ sender: Any) {
        location = LocationName.text!
    }
    
    @IBOutlet weak var Description: UILabel!
    
    @IBAction func Description(_ sender: Any) {
        info = Description.text!
    }
    
    @IBOutlet weak var NumPeople: UILabel!
    
    @IBOutlet weak var NumberOfPeople: UILabel!
    
    @IBAction func NumberOfPeople(_ sender: Any) {
        numPeople = NumberOfPeople.numberOfLines
    }
    
    @IBOutlet weak var CarPool: UILabel!
    
    @IBOutlet weak var CarPoolButton: UISwitch!
    
    @IBAction func CarPoolButton(_ sender: Any) {

        if CarPoolButton.isOn {
            CarPool.text = "Carpool Option On"
        } else {
            CarPool.text = "Carpool Option Off"
        }
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

