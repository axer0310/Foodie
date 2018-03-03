//
//  Party.swift
//  Foodie
//
//  Created by Samrat  on 2/7/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class PartyViewController: UIViewController
{
 
    var ref: DatabaseReference!
    var partyName: String = ""
    var location: String = ""
    var info: String = ""
    var numPeople: String = "";
    var x: Double = 40.4278709
    var y: Double = -86.9169629
    
    
    

    
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var Description2: UITextField!
    
    @IBAction func Description(_ sender: Any) {

        info = Description2.text!
    }
    
    @IBOutlet weak var NumPeople: UILabel!
    
    @IBOutlet weak var NumberOfPeople: UILabel!
    
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
        ref = Database.database().reference()

        self.navigationItem.title = "Create Party"
    }
    
        
        // Do any additional setup after loading the view, typically from a nib.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

