//
//  FriendListViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/18.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var friendList = [String]()
    var dataList = [[String:AnyObject]]()
    var user = User()
    var ref = Database.database().reference()
    let locationManager = CLLocationManager()
    var flag = 0

    

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        
        ref.child("/Users/\(user.id)/Coordinate").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String:Double]
            if let coordinate = value
            {
                if (coordinate["x"] == -1 && coordinate["y"] == -1)
                {
                    self.StatusCheck.setOn(false, animated: true)
                }
                else
                {
                    self.StatusCheck.setOn(true, animated: true)
                }
            }
            for friend in self.friendList
            {
                print(friend)
            }
            self.getData()
        })
        
        
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
     
        flag = 1
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var StatusCheck: UISwitch!

    
    @IBAction func StatusCheck(_ sender: Any) {


        
        
        
        if !StatusCheck.isOn {
            let xVal = ["Users/\(user.id)/Coordinate/x": -1]
            let yVal = ["Users/\(user.id)/Coordinate/y": -1]
            
            ref.updateChildValues(xVal)
            ref.updateChildValues(yVal)
            
        } else {
        
            
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
            {
                let xVal = ["Users/\(user.id)/Coordinate/x": (locationManager.location?.coordinate.latitude)!]
                let yVal = ["Users/\(user.id)/Coordinate/y": (locationManager.location?.coordinate.longitude)!]
                
                ref.updateChildValues(xVal)
                ref.updateChildValues(yVal)
            }
            else
            {
                var alert = UIAlertView()
                alert.title = "Unable to Locate"
                alert.message = "Please enable location service in privacy settings."
                alert.addButton(withTitle: "OK")
                alert.show()
            }
            
        }
    }
    
    
}
