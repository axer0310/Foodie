//
//  ResturantViewController.swift
//  Foodie
//
//  Created by Smile. on 08/02/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResturantViewController:UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Search: UISearchBar!
        var businesses: [Business]!
    var locationManager : CLLocationManager!
    var annot : MKClusterAnnotation!
    override func viewDidLoad() {
        super.viewDidLoad()
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        let searchBar = UISearchBar()
        searchBar.delegate = self as! UISearchBarDelegate
        
        self.navigationItem.titleView = searchBar
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
//            self.tableView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
                self.addAnnotationAtAddress(address: business.address!, title: business.name!)
            }
            } as! ([Business]?, Error?) -> Void)
            // Do any additional setup after loading the view.
        }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "An annotation!"
        mapView.addAnnotation(annotation)
    }
    
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "customAnnotationView"
            // custom pin annotation
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if (annotationView == nil) {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            else {
                annotationView!.annotation = annotation
            }
            annotationView!.pinTintColor = UIColor.green
            
            return annotationView
        }
        // custom image annotation
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage(named: "customAnnotationImage")
        
        return annotationView
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Business.searchWithTerm(term: searchText, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }
    
}
