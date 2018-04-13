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
    var carpool_status: Bool = false;
    var randString: String = ""
    var user = User()
    
    func NextButton() {
        
        let randomString = Helper.randomString(length: 16)
        randString = randomString
        let previousPartyLocation: String = "previousPartyLocation"
        
        let post = [ "Carpool": carpool_status ,"Name": partyName, "Location": location, "Coordinate": ["x" : x, "y": y], "Description": info, "MemberLimit": (NumberOfPeople.text)] as [String : Any]
        
        let childUpdates = ["PartyIDs/\(randomString)": post ]
        ref.updateChildValues(childUpdates)

        
        //Before this works fine
//        var userInfo = firebaseUserInfo()
//        let partyString = ["PartyID" : randomString, "Location" : location]
//        
//    
//        let userParty = ["/Users/\(self.user.id)/previousPartyLocation" : partyString]
//                ref.updateChildValues(userParty)
    }
    
    @IBAction func viewPartyHistory(_ sender: Any)
    {
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
            carpool_status = true
            CarPool.text = "Carpool Option On"
        } else {
            carpool_status = false
            CarPool.text = "Carpool Option Off"
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = Database.database().reference()
        CarPoolButton.isOn = false
        self.navigationItem.title = "Create Party"
    }
    
        
        // Do any additional setup after loading the view, typically from a nib.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "presentPartyDisplay"
        {
            NextButton()
            var vc = segue.destination as? MainPartyViewController
            if let vc = vc {
                var party = Party()
                party.PartyID = randString
                vc.user = user
            }
        }
        else if segue.identifier == "viewAllParties"
        {
            var vc = segue.destination as? MainPartyViewController
            if let vc = vc
            {
                vc.user = user
            }
            print("viewingAllParties")
        }
        else if segue.identifier == "partyHistory"
        {
            var vc = segue.destination as? PartyHistoryTableViewController
            if let vc = vc
            {
                vc.user = user
            }

        }
    }
    
    
    @IBOutlet weak var ViewParties: UIButton!
    
    @IBAction func ViewParties(_ sender: Any) {
        
    }
    
    
    
}








