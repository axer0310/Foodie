//
//  TipCalculatorViewController.swift
//  Foodie
//
//  Created by Samrat  on 3/30/18.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase


class TipCalculatorViewController: UIViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tip Calculator"
}
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
func addAnnotationAtAddress(address: String, title: String, subtitle: String , lat: Double, long: Double, moreInfo: Dictionary<String, Any>) {
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
                annotation.imageURL = moreInfo["ImageURL"] as! URL
                annotation.distance = moreInfo["Distance"] as! String
                annotation.rating = moreInfo["Rating"] as! Double
                annotation.reviewCount = moreInfo["reviewCount"] as! Int
                annotation.reviewwritten = moreInfo["Reviews"] as! String
                if let phone = moreInfo["Phone"] as? String
                {
                    annotation.phone  = phone
                }
                //                    annotation.phone = (moreInfo["Phone"] as? String)!
                annotation.id = moreInfo["ID"] as! String
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
    
