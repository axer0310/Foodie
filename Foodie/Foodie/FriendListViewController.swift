//
//  FriendListViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/18.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var friendList = [String]()
    var dataList = [[String:AnyObject]]()
    var user = User()
    var ref = Database.database().reference()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        ref.child("/Users/\(user.id)/FriendIDs").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String]
            if let friends = value
            {
                for friend in friends
                {
                    self.friendList.append(friend as! String)
                }
                
            }
            for friend in self.friendList
            {
                print(friend)
            }
            self.getData()
        })
        
    }
    func getData()
    {
        for id in friendList
        {
            ref.child("/Users/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? [String:AnyObject]
                if let data = value
                {
                    self.dataList.append(data)
                }
                self.tableView.reloadData()
            })
        }
        
    }
    @IBAction func showMap(_ sender: Any)
    {
        if let story = UIStoryboard.init(name: "FriendLocation", bundle: nil) as? UIStoryboard
        {
            if let nav = story.instantiateViewController(withIdentifier: "FriendLocationNav") as? UINavigationController
            {
                if let vc = nav.childViewControllers[0] as? FriendLocationViewController
                {
                    vc.friendList = friendList
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendListCell
        
        let data = dataList[indexPath.row]
        
        if let name = data["Name"] as? String
        {
            cell.Name.text = name
        }
        if let urlStr = data["ProfilePic"] as? String
        {
            let url = URL.init(string: urlStr)
            if let data = try? Data(contentsOf: url!)
            {
                cell.ProfilePic.image = UIImage(data: data)!
            }
            else
            {
                print("Cant get profile pic")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataList.count;
    }
    @IBAction func dismiss(_ sender: Any)
    {
         self.dismiss(animated: true, completion: nil)
    }
}
