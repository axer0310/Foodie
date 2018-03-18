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

class FriendListViewController: UITableViewController
{
    var friendList = [String]()
    var user = User()
    var ref = Database.database().reference()

    
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
        })
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendListCell
        cell.Name.text = user.name
        var url = URL.init(string: user.profilePicUrlStr)!
        do
        {
            if let data = try? Data(contentsOf: url)
            {
                cell.ProfilePic.image = UIImage(data: data)!
            }
        }
        catch
        {
            print(error)
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return friendList.count;
    }
}
