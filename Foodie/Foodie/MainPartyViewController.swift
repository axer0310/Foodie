//
//  MainPartyViewController.swift
//  Foodie
//
//  Created by Samrat  on 3/8/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase


class MainPartyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var partyList = [String]()
    var partyIDList = [String]()
    var dataList = [[String:AnyObject]]()
    var user = Party()
    
    var ref = Database.database().reference()
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Parties List"
        
//        self.tableView.delegate = self
        
        ref.child("/PartyIDs").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String:AnyObject]
            if let parties = value
            {
                
                for party in parties.values
                {
                    if let partyDic = party as? [String:AnyObject]
                    {
                       var partyID = partyDic["Name"] as? String
                        self.partyList.append(partyID!)
                    }
                }
                self.tableView.reloadData()
                self.tableView.delegate = self
                self.tableView.dataSource = self
            }
        })
        ref.child("/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String:AnyObject]
            if let data = value
            {
                var array = [String]()
                if let ids = data["PartyIDs"] as? [String: AnyObject]
                {
                    for id in ids
                    {
                        self.partyIDList.append(id.key)
                    }
                    
                }
                
//                for id in data["PartyIDs"]?.values as? [String]
//                {
//                    array.append(id)
//                }
            }
            
                //                var partyIDs = data["PartyIDs"] as? [String]
//                if let partyIDs = partyIDs
//                {
//                    self.partyIDList = partyIDs
//                }
                
            
//            if let parties = value
//            {
//
//                for party in parties.values
//                {
//                    if let partyDic = party as? [String:AnyObject]
//                    {
//                        var partyID = partyDic["Name"] as? String
//                        self.partyList.append(partyID!)
//                    }
//                }
//                self.tableView.reloadData()
//                self.tableView.delegate = self
//                self.tableView.dataSource = self
//            }
        })


    }
    
//    func getData()
//    {
//        for id in friendList
//        {
//            ref.child("/PartyIDs/\(id)/Name").observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let value = snapshot.value as? [String:AnyObject]
//                if let data = value
//                {
//                    self.dataList.append(data)
//                }
//                self.tableView.reloadData()
//            })
//        }
//
//    }
    
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    @IBAction func DoneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "PartyCell") as! MainPartyTableViewCells
            cell.PartyName.text = partyList[indexPath.row]
//        let data = dataList[indexPath.row]
//
//        if let name = data["PartyName"] as? String
//        {
//            cell.PartyName.text = name
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let sb = UIStoryboard.init(name: "Chat", bundle: nil) as? UIStoryboard
        {
            
                if let vc = sb.instantiateViewController(withIdentifier: "chatRoomView") as? ChatRoom
                {
                    vc.path = "/PartyIDs/\(partyIDList[indexPath.row])/chats"
                    self.present(vc, animated: true, completion: nil)
                }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count;
    }

}




