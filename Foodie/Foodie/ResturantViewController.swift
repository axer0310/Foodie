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
import YelpAPI

class ResturantViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var center: CLLocationCoordinate2D!
    var annotation: Array<MKPointAnnotation>!

    override func viewDidLoad(){
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//
//        let jsonUrlString = "https://api.yelp.com/v3/businesses/search"
//        guard let url = URL(string:jsonUrlString) else { return }
//        URLSession.shared.dataTask(with: url){
//            (data, response, err) in
//
//            guard let data = data else { return }
//            let dataString = String(data: data, encoding: .utf8)
//            print(dataString ?? "")
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
//
//                let places = Places(json: json)
//                print(places.term)
//            } catch let jsonErr{
//                print("Error with json ", jsonErr)
//            }
//        }.resume()
//        
//        //Annotation
//        let locations : NSMutableArray = []
//        var location = CLLocationCoordinate2D()
//        let anno1 = MKPointAnnotation()
//        
//        location.latitude = multi_lat1
//        location.longitude = multi_lon1
//        anno1.coordinate = CLLocationCoordinate2D(latitude: multi_lat1, longitude: multi_lon1)
//        locations.add(anno1)
//        
//        Map.addAnnotation(locations as! MKAnnotation)
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
