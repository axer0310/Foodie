
//  ChatViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 10..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import SnapKit
import FirebaseDatabase
import GoogleSignIn

<<<<<<< HEAD
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array : [UserModel] = []
=======
//class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

>>>>>>> master
    
    @IBOutlet weak var chatTitle: UILabel!
    //@IBOutlet weak var tableView: UITableView!
    
<<<<<<< HEAD
    var tableView: UITableView
    
//    var ref: DatabaseReference!
//    var partyName: String = ""
//    var location: String = ""
//    var info: String = ""
//    var numPeople: String = "";
//    var x: Double = 40.4278709
//    var y: Double = -86.9169629
//
    override func viewDidLoad() {
        super.viewDidLoad()
        //database = firebase.database()
//        tableView.delegate = self
//        tableView.dataSource = self
//
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: <#T##String#>,"Cell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(view).offset(20)
            m.bottom.left.right.equalTo(view)
        }
    
        Database.database().reference().child("Users").observe(DataEventType.value) { (snapshot) in
            
            self.array.removeAll()
            
            for child in snapshot.children {
                
                let fchild = child as! DataSnapShot
                
                let userModel = UserModel()
                
                userModel.setValuesForKeys(fchild.value as! [String : Any])
                self.array.append(UserModel )
            
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath)
        
        //URLSession.dataTask(with: URL(string: array[indexPath.row].profileImageURL)
        
        let label = UILabel()
        cell.addSubview(label)
        label.snp.makeConstraints { (m) in
            m.centerY.equalTo(cell)
        }
        
        label.text = array[indexPath.row].userName
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
=======
 
    var user = User()
    var friendList = [String]()
    var friendIDList = [String]()
    var dataList = [[String:AnyObject]]()

    @IBOutlet var tableView: UITableView!
    var ref = Database.database().reference()
    var friendID = ""
    
    
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
                    self.friendIDList.append(id)
                }
                self.tableView.reloadData()
            })
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        var bufferList = [String]()
//        for ids in dataList
//        {
//            for value in ids
//            {
//                bufferList.append(value.key)
////                bufferList.append()
//            }
//
//        }
        friendID = friendIDList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatFriendCell") as! FriendListCell
        
        let data = dataList[indexPath.row]
>>>>>>> master
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goChat"
        {
            var dest = segue.destination as? ChatRoom
            if let dest = dest
            {
                dest.path = "/Users/\(user.id)/chats/"
                dest.chatVC = self
            }
        }
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
<<<<<<< HEAD
        //let post = ["Party Name": partyName, "Coordinate": ["x" : x, "y": y], "Description": info, "Number of People": (NumberOfPeople.text)] as [String : Any]
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        //performSegue(withIdentifier: "userList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "userList" {
//            let userListVC = segue.destination as! UserListViewController
//            let chatGroupVC = sender as! ChatGroupViewController
//            userListVC.chatGroupVC = chatGroupVC
//        } else if segue.identifier == "chatting" {
//            let chatVC = segue.destination as! ViewController
//            chatVC.groupKey = sender as? String
//        }
    }
    
    func fetchChatGroupList() {
//        if let uid = FirebaseDataService.instance.currentUserUid {
//            FirebaseDataService.instance.userRef.child(uid).child("groupList").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            }
//        }
=======
        
>>>>>>> master
    }
    
  
}

