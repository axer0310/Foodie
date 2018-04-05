//
//  uberViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/4/1.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import UberRides
import CoreLocation

class uberViewController: UIViewController
{
    
    let button = RideRequestButton()
    let locationManager = CLLocationManager()
    override func viewDidLoad()
    {
        let builder = RideParametersBuilder()
        
        let pickupLocation = locationManager.location
        let dropoffLocation = CLLocation(latitude: 37.775200, longitude: -122.417587)
        builder.pickupLocation = pickupLocation
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "Somewhere"
        builder.dropoffAddress = "123 Fake St."
        let rideParameters = builder.build()
        button.rideParameters = rideParameters
        button.frame = CGRect(x: 65,y: self.view.frame.size.height/2,width: 250,height:  50)
        self.view.addSubview(button)
    }
    @IBAction func dismiss(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
