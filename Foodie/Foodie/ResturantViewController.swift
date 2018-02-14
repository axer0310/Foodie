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

class ResturantViewController: UIViewController {
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad(){
        var location = CLLocationCoordinate2DMake(-33.86,
                                                  151.20)
        
        var span = MKCoordinateSpanMake(0.2, 0.2)
        var region = MKCoordinateRegion(center: location, span: span)
        Map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location);
        annotation.title = "Sydney"
        annotation.subtitle="australia"
        
        Map.addAnnotation(annotation)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//override func loadView() {
//    // Create a GMSCameraPosition that tells the map to display the
//    // coordinate -33.86,151.20 at zoom level 6.
//    l
//    // Creates a marker in the center of the map.
//    let marker = GMSMarker()
//    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//    marker.title = "Sydney"
//    marker.snippet = "Australia"
//    marker.map = mapView
//}
//}
/*
 super.viewDidLoad()
 GMSServices.provideAPIKey("AIzaSyAfqMr44xiniiI-caeIV2bo8lh3z-QfzrE")
 let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
 let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
 view = mapView
 
 let currentLocation = CLLocationCoordinate2DMake(-33.86, 151.20)
 let marker = GMSMarker(position: currentLocation)
 marker.title = "Sydney"
 marker.map = mapView
 
 //    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action:"next")*/

}
