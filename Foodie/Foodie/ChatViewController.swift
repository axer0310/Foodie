//
//  ChatViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 10..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class ChatViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var chatTitle: UILabel!
    

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var partyName: String = ""
    var location: String = ""
    var info: String = ""
    var numPeople: String = "";
    var x: Double = 40.4278709
    var y: Double = -86.9169629
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //database = firebase.database()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func letsParty(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the party server
        //let post = ["Party Name": partyName, "Coordinate": ["x" : x, "y": y], "Description": info, "Number of People": (NumberOfPeople.text)] as [String : Any]
        
    }
    
    @IBAction func qrcode(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the qrcode
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

