//
//  ChatViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 10..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn

//class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    @IBOutlet weak var chatTitle: UILabel!
    
 
    var user = User()
    var friendList = [String]()
    var dataList = [[String:AnyObject]]()

    @IBOutlet var tableView: UITableView!
    var ref = Database.database().reference()
    
    
    
    //var tableView1: UITableView!
    
    override func viewDidLoad()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
//            self.tableView.reloadData()
            
            
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

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatFriendCell") as! FriendListCell
        
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

//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        let imageview = UIImageView()
//        cell.addSubview(imageview)
//        imageview.snp.makeConstraints { (m) in
//            m.centerY.equalTo(cell)
//            m.left.equalTo(cell)
//            m.height.width.equalTo(50)
//        }
//
//        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].profileImageUrl!)!) { (data, response, err) in
//
//            DispatchQueue.main.async {
//                imageview.image = UIImage(data: data!)
//                imageview.layer.cornerRadius = imageview.frame.size.width/2
//                imageview.clipsToBounds = true
//            }
//
//        }.resume()
//
//        let label = UILabel()
//        cell.addSubview(label)
//        label.snp.makeConstraints { (m) in
//            m.centerY.equalTo(cell)
//            m.left.equalTo(imageview.snp.right).offset(30)
//        }
//
//        label.text = array[indexPath.row].userName
//
//        return cell
//    }
////
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 70
////    }
////
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatRoom") as? ChatRoom
//        view?.destinationUid = self.array[indexPath.row].uid
//
//        self.navigationController?.pushViewController(view!, animated: true)
//    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
    @IBAction func letsParty(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the party server
        
    }
    
  
}

