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

class ResturantViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    let regionRad: CLLocationDistance =1000
    override func viewDidLoad(){
        super.viewDidLoad()
        (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
        mapView.delgate = self
        locationManager = CLLocationManager()
        locationManager.delegate=self
        locationManager.desiredAccurcy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
//        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRad * 2.0, regionRad * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    @IBAction func tapPiece(_ gestureRecogniser: UITapGestureRecognizer)
    guard gestureRecognizer.view != nil else { return }
    
    if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
            gestureRecognizer.view!.center.x += 100
            gestureRecognizer.view!.center.y += 100
        })
        animator.startAnimation()
    }}
}
