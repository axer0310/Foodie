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

class MainPageViewController: UIViewController
{
    var user = User()

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
        ref.child("/PartyIDs/Coordinate").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let x = Double( value?["x"] as! Double )
            let y = Double( value?["y"] as! Double )

            var pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            self.mapView.addAnnotation(pin)
            
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
}
