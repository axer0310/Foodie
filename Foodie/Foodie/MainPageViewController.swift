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
import SwiftQRCode


class MainPageViewController: UIViewController, MKMapViewDelegate
{
    var user = User()
    var loginEntry = LoginViewController()
    var ref = Database.database().reference()
    
    @IBOutlet var partyInfoView: UIView!
    @IBOutlet var partyNameLabel: UILabel!
    @IBOutlet var partyMemberLimitsLabel: UILabel!
    @IBOutlet var partyCarPoolOption: UILabel!
    @IBOutlet var partyDescriptionLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!

    
    override func viewDidLoad()
    {
        print(user.name)

        self.mapView.delegate = self
        getPartys()
        partyInfoView.isHidden = true
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
                        let title = partyDic["Name"] as? String
                        let pin = MKPointAnnotation()
                        pin.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
                        pin.title = title
                        
                        self.mapView.addAnnotation(pin)

                    }
                }
            }
        })

    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
//        partyInfoView.isHidden = false
        
//        if let annotationTitle = view.annotation?.title
//        {
//            print("User tapped on annotation with title: \(annotationTitle!)")
//        }
    }
    @IBAction func joinParty(_ sender: Any)
    {
    }
    @IBAction func reload(_ sender: Any)
    {
        getPartys()
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
                if let vc = nav.childViewControllers[0] as? ChatViewController
                {
                    vc.user = user
                    self.present(nav, animated: true, completion: nil)
                }
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
        
        
        if let story = UIStoryboard.init(name: "QR", bundle: nil) as? UIStoryboard
        {
            if let nav = story.instantiateViewController(withIdentifier: "QRNav") as? UINavigationController
            {
                if let vc = nav.childViewControllers[0] as? QRViewController
                {
                    vc.qrImage = QRCode.generateImage(user.id, avatarImage: UIImage(named: "avatar"))!
                    vc.user = self.user
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func showFriendList(_ sender: Any)
    {
        if let story = UIStoryboard.init(name: "FriendList", bundle: nil) as? UIStoryboard
        {
            if let nav = story.instantiateViewController(withIdentifier: "FriendListNav") as? UINavigationController
            {
                if let vc = nav.childViewControllers[0] as? FriendListViewController
                {
                    vc.user = self.user
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func logOut(_ sender: Any)
    {
        self.loginEntry.logOut()
        self.dismiss(animated: true, completion: nil)
    }
}
