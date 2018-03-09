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
//    @IBOutlet weak var Search: UISearchBar!
    var businesses: [Business]!
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var loclong = 0.0
    var loclat = 0.0
    var locationMan : CLLocationManager!
    //var annot : MKClusterAnnotation!
    fileprivate var searchController: UISearchController!
    fileprivate var localSearchRequest: MKLocalSearchRequest!
    fileprivate var localSearch: MKLocalSearch!
    fileprivate var localSearchResponse: MKLocalSearchResponse!
    
    fileprivate var annotation: MKAnnotation!
//    fileprivate var locationManager: CLLocationManager!
//    fileprivate var isCurrentLocation: Bool = false

    fileprivate var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let centerLocation = CLLocation(latitude: 40.4237, longitude: 86.9212)
        //goToLocation(location: centerLocation)
        
        locationMan = CLLocationManager()
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationMan.distanceFilter = 300
        locationMan.requestWhenInUseAuthorization()
        locationMan.startUpdatingLocation()
       
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(ResturantViewController.searchButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = searchButton
        mapView.delegate = self
//        mapView.mapType = .hybrid
        
        Business.searchWithTerm(term: "Asian", long: loclong, lat: loclat, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    self.addAnnotationAtAddress(address: business.address!, title: business.name!, subtitle: business.distance!)
                }
            }
        }
        )
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
    }
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationMan.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            self.mapView.setRegion(region, animated: true)
        }
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        loclat = locValue.latitude
        loclong = locValue.longitude
        
    }
    
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String, subtitle: String) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    annotation.subtitle = subtitle
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
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
    
//    func searchBar(Search: UISearchBar, textDidChange searchText: String) {
//        Business.searchWithTerm(term: searchText, long: loclong, lat: loclat, completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//
//            for business in businesses {
//                print(business.name!)
//                print(business.address!)
//                self.addAnnotationAtAddress(address: business.address!, title: business.name!, subtitle: business.distance!)
//            }
//            } as! ([Business]?, Error?) -> Void)
//    }
    
    
    // MARK: - Search
    
    @objc func searchButtonAction(_ button: UIBarButtonItem) {
        if searchController == nil {
            searchController = UISearchController(searchResultsController: nil)
        }
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self as! UISearchBarDelegate
        present(searchController, animated: true, completion: nil)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { [weak self] (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil {
                let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
            }
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = searchBar.text
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
            self!.mapView.centerCoordinate = pointAnnotation.coordinate
            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
        }
    }
    
    
}
