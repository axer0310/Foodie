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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "presentPartyDisplay"
        {
            NextButton()
            var vc = segue.destination as? MainPartyViewController
            if let vc = vc {
                var party = Party()
                party.PartyID = randString
                vc.user = party
            }
        }
        else if segue.identifier == "viewAllParties"
        {
            print("viewingAllParties")
        }
    }
    
    
    @IBOutlet weak var ViewParties: UIButton!
    
    @IBAction func ViewParties(_ sender: Any) {
        
    }
    
    
    
}








