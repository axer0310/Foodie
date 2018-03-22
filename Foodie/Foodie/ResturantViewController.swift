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

class ResturantViewController:UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Search: UISearchBar!
    var businesses: [Business]!
//    @IBAction func BackButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    var locationMan : CLLocationManager!
    //var annot : MKClusterAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let centerLocation = CLLocation(latitude: 40.4237, longitude: 86.9212)
        //goToLocation(location: centerLocation)
        
        locationMan = CLLocationManager()
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationMan.distanceFilter = 200
        locationMan.requestWhenInUseAuthorization()
        
//        let Search = UISearchBar()
        Search.delegate = self 
        
        //        self.navigationItem.titleView = Search
        mapView.delegate = self
        //        self.view.addSubview(mapView)
        
        Business.searchWithTerm(term: "restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    var moreinfo = [business.name!, business.address!, business.imageURL!, business.distance!, business.rating!, business.reviewCount!] as [Any]
//                    var name = ""
//                    var address = ""
//                    var imageURL = URL.init(string: "")
//                    var distance = ""
//                    var ratingImageURL = URL.init(string: "")
//                    var reviewCount = 0
//                    var rating = 0.0
//                    var phone = ""
//                    var id = ""
//                    var reviewwritten = ""
                    self.addAnnotationAtAddress(address: business.address!, title: business.name!, subtitle: business.distance!, lat: business.lat!, long: business.long!, moreInfo: moreinfo)
                }
            }
            
        }
        )
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
    }
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String, subtitle: String , lat: Double, long: Double, moreInfo: [Any]) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = Food(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
//                    annotation.
//                    annotation.coordinate = coordinate.coordinate
                    annotation.name = title
                    annotation.address = subtitle
                    //[business.name!, business.address!, business.imageURL!, business.distance!, business.rating!, business.reviewCount!]
                    annotation.imageURL = moreInfo[2] as! URL
                    annotation.distance = moreInfo[3] as! String
                    annotation.rating = moreInfo[4] as! Double
                    annotation.reviewCount = moreInfo[5] as! Int
//                    annotation.description.append(id)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
        if annotation is MKUserLocation { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
//            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = UIColor.green
//        annotationView?.titleVisibility
//        annotationView.
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = view.annotation
        let storyboard = UIStoryboard(name: "ResturantPage", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "detailView") as! DetailviewController
        
        detailVC.storename = ((annView?.title!)!)
        detailVC.sub = ((annView?.subtitle!)!)
//        detailVC.id = ((annView?.description)!)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let innerAnnotation = view.annotation as! Food
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil) //!!!!!!ERRROR HEREEE
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.MainName.text = innerAnnotation.name
        calloutView.MainAddress.text = innerAnnotation.address
        calloutView.MainPhone.text = innerAnnotation.phone
//        calloutView.starbucksImage.image = starbucksAnnotation.image
        let button = UIButton(frame: calloutView.MainPhone.frame)
//        button.addTarget(self, action: #selector(ResturantViewController.callPhoneNumber(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
//        present(detailedVC, animated: true, completion: nil)
//        present
    }
    
//
//    func searchBar(Search: UISearchBar, textDidChange searchText: String)
//    {
//
//        print(searchText)
//        Business.searchWithTerm(term: searchText, completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//
//            for business in businesses {
//                print(business.name!)
//                print(business.address!)
//            }
//            } as! ([Business]?, Error?) -> Void)
//    }
    
}
