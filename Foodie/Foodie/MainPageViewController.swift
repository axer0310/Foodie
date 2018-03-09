//
//  MainPage.swift
//  Foodie
//
//  Created by Arthur on 2018/2/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MapKit
import QRCode

class MainPageViewController: UIViewController
{
    var user = User()
    var loginEntry = LoginViewController()
    var ref = Database.database().reference()
    
    @IBOutlet var mapView: MKMapView!

    
    override func viewDidLoad()
    {
        print(user.name)

//        self.mapView.delegate = self
        getPartys()
        
    }
    func getPartys()
    {
        ref.child("/PartyIDs").observeSingleEvent(of: .value, with: { (snapshot) in

            let value = snapshot.value as? [String:AnyObject]
            if let parties = value
            {
                for party in parties.values
                {
                    if let partyDic = party as? [String:AnyObject]
                    {
                        let coordinate = partyDic["Coordinate"] as? NSDictionary
                        let x = Double( coordinate?["x"] as! Double )
                        let y = Double( coordinate?["y"] as! Double )

                        var pin = MKPointAnnotation()
                        pin.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
                        self.mapView.addAnnotation(pin)

                    }
                }
            }
        })

    }
    @IBAction func showRestaurant(_ sender: Any)
    {
        if let sb = UIStoryboard.init(name: "ResturantPage", bundle: nil) as? UIStoryboard
        {
            if let vc = sb.instantiateViewController(withIdentifier: "RestaurantView") as? ResturantViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        
        
    }
   

    @IBAction func showChatView(_ sender: Any)
    {
        if let sb = UIStoryboard.init(name: "Chat", bundle: nil) as? UIStoryboard
        {
            if let nav = sb.instantiateViewController(withIdentifier: "ChatNavigationController") as? UINavigationController
            {
                self.present(nav, animated: true, completion: nil)

            }
        }
   
    }
    @IBAction func showParty(_ sender: Any)
    {
        if let storyboard =  UIStoryboard(name: "Party", bundle: nil) as? UIStoryboard
        {
            if let nav = storyboard.instantiateViewController(withIdentifier: "PartyNavigation") as? UINavigationController
                
            {
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    @IBAction func showQR(_ sender: Any)
    {
        var qrCode = QRCode(user.id)
        qrCode?.size = CGSize(width: 30, height: 30)
        
        if let story = UIStoryboard.init(name: "QR", bundle: nil) as? UIStoryboard
        {
            if let vc = story.instantiateViewController(withIdentifier: "QRView") as? QRViewController
            {
                vc.qrImage = (qrCode?.image)!
                self.present(vc, animated: true, completion: nil)
            }
        }
        
       
       
    
       
//        var vc = UIView()
//        var qrView = UIImageView()
//        qrView.image = qrCode?.image
//        qrView.frame = CGRect(x: 0, y: 0, width: 0.5 * self.mapView.bounds.width, height: self.mapView.bounds.height )
//        vc.frame = CGRect(x: 0, y: 0, width: 0.5 * self.mapView.bounds.width, height: self.mapView.bounds.height )
//        vc.backgroundColor = UIColor.blue
//        self.mapView.isHidden = true
//        self.view.addSubview(vc)

        
    }
    @IBAction func logOut(_ sender: Any)
    {
        self.loginEntry.logOut()
        self.dismiss(animated: true, completion: nil)
    }
}
