//
//  CreateRoom.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 2. 22..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import JSQMessagesViewController
import CoreLocation
import UberRides

class ChatRoom:JSQMessagesViewController
{
    
    var messages = [JSQMessage]()
    var REF :  DatabaseReference?
    var REF2 :  DatabaseReference?
    var chatVC : ChatViewController?
    var partyID = ""
    var path = "chats"
    var userid = ""
    var friendid = ""
    
    /*
    var outgoingBubble = setupOutgoingBubble()
    var incomingBubble = setupIncomingBubble(nil)
    
    func setupIncomingBubble(gender: String?) -> JSQMessagesBubbleImage {
    switch gender {
        case "male":
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(hexString: "2573C5"))
        case "female":
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(hexString: "E452CE"))
        default:
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(hexString: "848484"))
    }
     }
     
     let message = messages[indexPath.row]
     
     if message.senderId == self.senderId {
     cell.textView!.textColor = UIColor.black
     }
     else {
     cell.textView!.textColor = UIColor.blue
     }
     
    */
    
    
    
    var ref = Database.database().reference()
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backbutton.backgroundColor = .blue
        backbutton.setTitle("Back", for: .normal)
        backbutton.addTarget(self, action: #selector(BackButton), for: .touchUpInside)
        self.view.addSubview(backbutton)
        
        var partyLocation =  CLLocation()
        ref.child("/PartyIDs/\(partyID)/Coordinate").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String:Double]
            if let Coordinate = value
            {
                print("\(Coordinate["x"])   \(Coordinate["y"])")
               partyLocation = CLLocation(latitude: Coordinate["x"]!, longitude: Coordinate["y"]!)
            }
            
            let button = RideRequestButton()
            let locationManager = CLLocationManager()
            let builder = RideParametersBuilder()
            let pickupLocation = locationManager.location
            let dropoffLocation = partyLocation
            print(partyLocation.coordinate)
            builder.pickupLocation = pickupLocation
            builder.dropoffLocation = dropoffLocation
            builder.dropoffNickname = "Party Destination"
            let rideParameters = builder.build()
            button.rideParameters = rideParameters
            button.frame = CGRect(x: self.view.frame.size.width-30,y: 20,width: 30,height:  30)
            
            
            
            self.view.addSubview(button)

        })

        
        
        
        if let chatVC = chatVC
        {
            path += chatVC.friendID
        }
        else
        {
            path+=""
        }
        
        self.REF = Database.database().reference().child(path)
        if let chatVC = chatVC
        {
            self.REF2 = Database.database().reference().child("/Users/\(chatVC.friendID)/chats/\(chatVC.user.id)")

        }
        //        senderId = "1234"
//        senderDisplayName = "human1"
//        
        let defaults = UserDefaults.standard
        
        if  let id = defaults.string(forKey: "jsq_id"),
            let name = defaults.string(forKey: "jsq_name")
        {
            senderId = id
            senderDisplayName = name
        }
        else
        {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = ""
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            
            showDisplayNameDialog()
        }
        
        title = "Chat: \(senderDisplayName!)"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
        tapGesture.numberOfTapsRequired = 1
        
        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        let query = self.REF!.queryLimited(toLast: 10)
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
    }
    
    @objc func showDisplayNameDialog()
    {
        let defaults = UserDefaults.standard
        
        let alert = UIAlertController(title: "Your Display Name", message: "Please choose a display name.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            if let name = defaults.string(forKey: "jsq_name")
            {
                textField.text = name
            }
            else
            {
                let names = ["Ford", "Arthur", "Zaphod", "Trillian", "Slartibartfast", "Humma Kavula", "Deep Thought"]
                textField.text = names[Int(arc4random_uniform(UInt32(names.count)))]
            }
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] _ in
            
            if let textField = alert?.textFields?[0], !textField.text!.isEmpty {
                
                self?.senderDisplayName = textField.text
                
                self?.title = "Chat: \(self!.senderDisplayName!)"
                
                defaults.set(textField.text, forKey: "jsq_name")
                defaults.synchronize()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = self.REF!.childByAutoId()
        var ref2 : DatabaseReference
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        if let ref = self.REF2?.childByAutoId()
        {
            ref2 = ref
            ref2.setValue(message)
        }

        ref.setValue(message)
        
        
        finishSendingMessage()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
}
