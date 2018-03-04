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
    
    
    @IBAction func NextButton(_ sender: Any) {
        
        let post = ["Party Name": partyName, "Coordinate": ["x" : x, "y": y], "Description": info, "Number of People": (NumberOfPeople.text)] as [String : Any]
        let childUpdates = ["/PartyIDs": post]
        ref.updateChildValues(childUpdates)
        ref.updateChildValues(childUpdates)
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
//        var rootRef = Database(url: "https://foodie-1e106.firebaseio.com/")
//
//        rootRef.setValue("Doing something!!")
//        rootRef.observeEventType(.Value, withBlock:{
//            snapshot in
//            print("\(snapshot.key)-> \(snapshot.value)")
//        })
        self.navigationItem.title = "Create Party"
    }
    
        
        // Do any additional setup after loading the view, typically from a nib.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

