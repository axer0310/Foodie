//
//  FriendLocationViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/20.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import MapKit
import Firebase
import UIKit
class FriendLocationViewController:UIViewController
{
    var user = User()
    var friendList = [String]()
    var ref = Database.database().reference()
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad()
    {
//        mapView.delegate = self
        getLocationData()
        
    }
    @IBAction func refresh()
    {
        getLocationData()
    }
    @IBAction func dismiss()
    {
        self.dismiss(animated: true, completion: nil)
    }
    func getLocationData()
    {
        for id in friendList
        {
            ref.child("/Users/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? [String:AnyObject]
                
                if let data = value
                {
                    let pin = MKPointAnnotation()
                    if let name = data["Name"] as? String
                    {
                        pin.title = name
                    }
                    
                    if let coordinate = data["Coordinate"] as? [String:AnyObject]
                    {
                        
                        let x = Double( coordinate["x"] as! Double )
                        let y = Double( coordinate["y"] as! Double )
                        
                        
                        if(x != 0 && y != 0)
                        {
                            
                            pin.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
                            
                        }
                    }
                    if(pin.coordinate != nil && pin.title != nil)
                    {
                        self.mapView.addAnnotation(pin)
                    }
                }
                
                
            })

        }
    }
    
    
}
