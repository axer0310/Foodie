//
//  PartyHistoryTableViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/4/12.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PartyHistoryTableViewController: UITableViewController
{
    var user = User()
    var ref = Database.database().reference()
    var history = [String]()
    var partyList = [String]()
    override func viewDidLoad()
    {
        self.navigationItem.title = "Party History"
        ref.child("/Users/\(self.user.id)/partyHistory").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String]
            if let data = value
            {
                for partyID in data
                {
                    self.history.append(partyID)
                }
            }
            
            
            for partyID in self.history
            {
                self.ref.child("/PartyIDs/\(partyID)/Location").observeSingleEvent(of: .value, with: { (snapshot) in
                     let value = snapshot.value as? String
                    if let data = value
                    {
                        self.partyList.append(data)
                    }
                    self.tableView.reloadData()
                })
            }
            
            
         
        })
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "PartyCell") as! MainPartyTableViewCells
        cell.PartyName.text = partyList[indexPath.row]
        return cell
    }
}
