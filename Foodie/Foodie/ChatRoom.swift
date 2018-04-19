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

class ChatRoom:JSQMessagesViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var messages = [JSQMessage]()
    var REF :  DatabaseReference?
    var REF2 :  DatabaseReference?
    var chatVC : ChatViewController?
    var partyID = ""
    var path = "chats"
    var userid = ""
    var friendid = ""
    
    class Setting {
        let colorSetting : CreateRoomViewController
        var text : String
        var background : String
        var bubble : String
        
        init() {
            
            self.colorSetting = CreateRoomViewController()
            
            self.text = colorSetting.textcolor
            self.background = colorSetting.backgroundcolor
            self.bubble = colorSetting.bubblecolor
            
        }
    }
    
    var imageToShare : UIImage?
    let picker = UIImagePickerController()
    
    var ref = Database.database().reference()
    
    //bubble color setting hr
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        
        let setting = Setting.init()
        var bubble : String
        
        let bubblec = UserDefaults.standard.string(forKey: "bubblecolor")
        
        
        bubble = setting.bubble
        
        if(bubblec == "Red") {
            return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleRed())
        }
        else if (bubblec == "Blue") {
            return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        }
        else if (bubblec == "Green") {
            return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        }
        else {
            return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        }
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        //return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        let setting = Setting.init()
        var bubble : String
        
        bubble = setting.bubble
        
        let bubblec = UserDefaults.standard.string(forKey: "bubblecolor")
        
        
        if(bubblec == "Red") {
            return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleRed())
        }
        else if (bubblec == "Blue") {
            return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        }
        else if (bubblec == "Green") {
            return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        }
        else {
            return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = false
        picker.delegate = self
        
        var partyLocation =  CLLocation()
        
        ref.child("/PartyIDs/\(partyID)/Coordinate").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String:Double]
            if let Coordinate = value
            {
                print("\(Coordinate["x"])   \(Coordinate["y"])")
               partyLocation = CLLocation(latitude: Coordinate["x"]!, longitude: Coordinate["y"]!)
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
                //            button.frame = CGRect(x: 0,y: 65,width: 30,height:  30)
                let barButton = UIBarButtonItem(customView: button)
                NSLayoutConstraint.activate([(barButton.customView!.widthAnchor.constraint(equalToConstant: 30)),(barButton.customView!.heightAnchor.constraint(equalToConstant: 30))])
                self.navigationItem.leftBarButtonItem = barButton
            }
            
           
            
            
//
//            button.frame = CGRect(x: 0,y: 0,width: 30,height:  30)
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
//            self.navigationItem.leftBarButtonItem?.customView?.widthAnchor.constraint(equalToConstant: 30)
//            self.navigationItem.leftBarButtonItem?.customView?.heightAnchor.constraint(equalToConstant: 30)
//            self.navigationItem.leftBarButtonItem!.customView!.frame =  CGRect(x: 20,y: 20,width: 30,height:  30)
//
            
//            self.navigationController?.navigationBar.
//            self.view.addSubview(button)

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
        tapGesture.numberOfTapsRequired = 5
        
        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        
        //change color background
        let setting = Setting.init()
        var background : String
        
        background = setting.background
        
        let backgroundc = UserDefaults.standard.string(forKey: "backgroundcolor")
        
        
        if(backgroundc == "Yellow") {
            self.collectionView.backgroundColor = UIColor.yellow;
        }
        
        if(backgroundc == "Green") {
            self.collectionView.backgroundColor = UIColor.green;
        }
        
        if(backgroundc == "Black") {
            self.collectionView.backgroundColor = UIColor.black;
        }
        
        if(backgroundc == "Brown") {
            self.collectionView.backgroundColor = UIColor.brown;
        }
        
        if(backgroundc == "Blue") {
            self.collectionView.backgroundColor = UIColor.blue;
        }
        
        if(backgroundc == "Cyan") {
            self.collectionView.backgroundColor = UIColor.cyan;
        }
        
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
                let names = ["Alex", "Arthur", "Ben", "Kevin", "Sarah", "Paul", "Peter"]
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
    
    // text color change hr
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        //let messages = self.messages[indexPath.item]
        

        let setting = Setting.init()
        var text : String
        
        text = setting.text
        
        let textc = UserDefaults.standard.string(forKey: "textcolor")
        
        if(textc == "Black") {
            cell.textView.textColor = UIColor.black
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.black, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else if(textc == "Red") {
            cell.textView.textColor = UIColor.red
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.red, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else if(textc == "Blue") {
            cell.textView.textColor = UIColor.blue
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.blue, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else if(textc == "Brown") {
            cell.textView.textColor = UIColor.brown
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.brown, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else if(textc == "Cyan") {
            cell.textView.textColor = UIColor.cyan
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.cyan, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else if(textc == "Dark Gray") {
            cell.textView.textColor = UIColor.darkGray
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.darkGray, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        else {
            cell.textView.textColor = UIColor.white
            cell.textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        }
        
        return cell
    
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
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageToShare = pickedImage
        }
        
        self.dismiss(animated: true, completion: {
            if let image = self.imageToShare
            {
                var activityController = UIActivityViewController.init(activityItems: [image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
            else
            {
                print("***noimage")
            }
        })
        
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func share()
    {
        let alert = UIAlertController(title: "Choose Image from", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        

    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
}
