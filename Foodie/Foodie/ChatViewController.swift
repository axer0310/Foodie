//
//  ChatViewController.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 10..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import FirebaseDatabase
import GoogleSignIn

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array : [UserModel] = []
    
    @IBOutlet weak var chatTitle: UILabel!
    //@IBOutlet weak var tableView: UITableView!
    
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
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func letsParty(sender: AnyObject) {
        // after touching this button
        // it has to work which relates the party server
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
    }
    
}

