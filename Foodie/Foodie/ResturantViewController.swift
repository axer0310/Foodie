//
//  ResturantViewController.swift
//  Foodie
//
//  Created by Smile. on 08/02/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

struct Places {
    let term: String
    let latitude: Double
    let longtitude: Double
    let rating: Double
}

class ResturantViewController: UIViewController , CLLocationManagerDelegate{
    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    var multi_lat1 = -33.86
    var multi_lon1 = 151.20
    override func viewDidLoad(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Annotation
        let locations : NSMutableArray = []
        var location = CLLocationCoordinate2D()
        let anno1 = MKPointAnnotation()
        
        location.latitude = multi_lat1
        location.longitude = multi_lon1
        anno1.coordinate = CLLocationCoordinate2D(latitude: multi_lat1, longitude: multi_lon1)
        locations.add(anno1)
        
        Map.addAnnotation(locations as! MKAnnotation)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpanMake(0.02,  0.02)
        let region = MKCoordinateRegion(center: center, span: span)
        Map.setRegion(region, animated: true)
        Map.showsUserLocation = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
