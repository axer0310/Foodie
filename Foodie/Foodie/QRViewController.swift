//
//  QRViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftQRCode
import UIKit
import Firebase

//class QRViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate
class QRViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    var qrImage = UIImage()
    @IBOutlet var QRView: UIImageView!

    var ref = Database.database().reference()
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var friendID = ""
    var user = User()
//    var isReading: Bool = false
    
    override func viewDidLoad()
    {
        self.QRView.image = qrImage
    }
    
    
    @IBAction func scanQR(_ sender: Any)
    {
        super.viewDidAppear(true)
        self.QRView.isHidden = true
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = self.view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        
        

    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        if(metadataObjects.count > 0)
        {
            let metaData = metadataObjects[0]
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let code = transformed
            {
                print(code.stringValue)
                if(code.stringValue != friendID)
                {
                    
                    friendID = code.stringValue!
                    updateFriendsList(friendID: friendID)
                    captureSession?.stopRunning()
                    
                    
                    
                   
                }
            }
        }
        else
        {
            print("None QR Code found")
        }
    }
    func updateFriendsList(friendID: String)
    {
        var friendList = [String]()
        var count = 0;
        print("/Users/\(user.id)/")
        ref.child("/Users/\(user.id)/FriendIDs").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? [String]
            if let friends = value
            {
                count = friends.count
                for friend in friends
                {
                    friendList.append(friend as! String)
                }
                friendList.append(friendID)
            }
            for friend in friendList
            {
                print(friend)
            }
            
            let childUpdates = ["/Users/\(self.user.id)/FriendIDs": friendList]
            self.ref.updateChildValues(childUpdates)
            
            
            //Verifying if add sucuess
            self.ref.child("/Users/\(self.user.id)/FriendIDs").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? [String]
                if let friends = value
                {
                    if(count < friends.count && friends[count] == friendID)
                    {
                        var alert = UIAlertView()
                        alert.title = "Success"
                        alert.message = "You have successfully added 1 friend"
                        alert.addButton(withTitle: "OK")
                        alert.show()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            })
            
            
        })
        
        
    }
    @IBAction func dismiss(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
