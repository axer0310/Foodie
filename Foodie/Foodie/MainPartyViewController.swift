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
    var carPoolList = [Bool]()
    var dataList = [[String:AnyObject]]()
//    var user = Party()
    var user2 = User()
    var user = User()
    
    let id  = firebaseUserInfo()
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
                        var carpool = partyDic["Carpool"] as? Bool
                        self.carPoolList.append(carpool!)
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
            }
            
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
        if(carPoolList[indexPath.row] == true)
        {
            cell.carpool.isHidden = false
        }
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
            if let nav = sb.instantiateViewController(withIdentifier: "PartyChatNavigationController") as? UINavigationController
            {
                
//                present(nav, animated: true)
                if let vc = nav.childViewControllers[0] as? ChatRoom
                {
                    vc.path = "/PartyIDs/\(partyIDList[indexPath.row])/chats"
                    self.present(vc, animated: true, completion: nil)
//                    "/Users/\(user.id)/Coordinate"
                    let partyString = ["PartyID" : partyIDList[indexPath.row], "Location" : "Some kind of location"]
                    let userParty = ["Users/\(user2.id)/previousPartyLocation" : partyString]
                    print(userParty)
                    ref.updateChildValues(userParty)
                    vc.partyID = partyIDList[indexPath.row]
                    
                    var history = [String]()
                    ref.child("/Users/\(self.user2.id)/partyHistory").observeSingleEvent(of: .value, with: { (snapshot) in
                                    let value = snapshot.value as? [String]
                                    if let data = value
                                    {
                                        for partyID in data
                                        {
                                            history.append(partyID)
                                        }
                                    }
                        if(!history.contains(self.partyIDList[indexPath.row]))
                        {
                            history.append(self.partyIDList[indexPath.row])
                        }
                        
                        
                        
                        let childUpdates = ["/Users/\(self.user2.id)/partyHistory": history] as [String : Any?]
                        self.ref.updateChildValues(childUpdates)
                        self.present(nav, animated: true, completion: nil)
                    })
                   
               
                }
                
            }
//                if let vc = sb.instantiateViewController(withIdentifier: "chatRoomView") as? ChatRoom
//                {
//                    vc.path = "/PartyIDs/\(partyIDList[indexPath.row])/chats"
//                    vc.partyID = partyIDList[indexPath.row]
//                    self.present(vc, animated: true, completion: nil)
//                }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyList.count;
    }

}





