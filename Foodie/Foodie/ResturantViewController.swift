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
    //@IBOutlet weak var Search: UISearchBar!
    @IBOutlet var infoView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var businesses: [Business]!
    var infoToPass: Food?
    
    @IBAction func searchButton(_ sender: Any)
    {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        present(search, animated: true, completion: nil)
    }
    var locationMan : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.isHidden = true
               locationMan = CLLocationManager()
        locationMan.delegate = self
        locationMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationMan.distanceFilter = 200
        locationMan.requestWhenInUseAuthorization()
        mapView.delegate = self
        Business.searchWithTerm(term: "restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    var moreinfo = ["Name": business.name, "Address":business.address, "ImageURL" : business.imageURL,"Distance": business.distance, "Rating": business.rating, "reviewCount" : business.reviewCount, "Phone": business.phone, "Reviews": business.reviewwritten, "ID": business.id] as Dictionary
                    self.addAnnotationAtAddress(address: business.address!, title: business.name!, subtitle: business.distance!, lat: business.lat!, long: business.long!, moreInfo: moreinfo)
                }
            }
        })
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
    func addAnnotationAtAddress(address: String, title: String, subtitle: String , lat: Double, long: Double, moreInfo: Dictionary<String, Any>) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = Food(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
                    annotation.name = title
                    annotation.address = subtitle
                    annotation.imageURL = moreInfo["ImageURL"] as! URL
                    annotation.distance = moreInfo["Distance"] as! String
                    annotation.rating = moreInfo["Rating"] as! Double
                    annotation.reviewCount = moreInfo["reviewCount"] as! Int
                    annotation.reviewwritten = moreInfo["Reviews"] as! String
                    if let phone = moreInfo["Phone"] as? String
                    {
                        annotation.phone  = phone
                    }
                    annotation.id = moreInfo["ID"] as! String
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
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = UIColor.green
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        self.infoToPass = view.annotation as? Food
        if let innerAnnotation = infoToPass {
            infoView.isHidden = false
            nameLabel.text = innerAnnotation.name
            addressLabel.text = innerAnnotation.address
            phoneLabel.text = innerAnnotation.phone
            
        }
        else {
            infoView.isHidden = true
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailView") {
            let detailVC = segue.destination as? DetailviewController
            if let vc = detailVC {
                vc.infos = infoToPass
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activity = UIActivityIndicatorView()
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        
        self.view.addSubview(activity)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = self.mapView.region
        let stringtext:String = (searchBar.text)!
        let active:MKLocalSearch = MKLocalSearch.init(request: request)
        
        active.start { (response, error) in
            
            activity.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if (response == nil && ((response?.boundingRegion) == nil))
            {
                print("ERROR")
                
                let alert = UIAlertController(title: "Not found", message: "Unable to find location", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print((response?.description)! + "//////\n")
                print(response?.mapItems)
                
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                var flag2 = -1
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                for i in self.businesses {
                    if (i.name!).contains(stringtext) {
                        print(i.name!)
                        print(i.address!)
                        var moreinfo = ["Name": i.name, "Address":i.address, "ImageURL" : i.imageURL,"Distance": i.distance, "Rating": i.rating, "reviewCount" : i.reviewCount, "Phone": i.phone, "Reviews": i.reviewwritten, "ID": i.id] as Dictionary
                        self.addAnnotationAtAddress(address: i.address!, title: i.name!, subtitle: i.distance!, lat: i.lat!, long: i.long!, moreInfo: moreinfo)
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpanMake(0.05, 0.05)
                        let region = MKCoordinateRegionMake(coordinate, span)
                        
                        self.mapView.setRegion(region, animated: true)
                        flag2 = 1
                        break
                    }

                }
//                lowercaseString.rangeOfString("swift") != nil
                
//                if let index = self.businesses?.index(where: { $0.name == stringtext}){
//                if let index = self.businesses?.index(where: { ($0.name)?.range(of: String(describing: stringtext), options: .caseInsensitive) != nil }){
                if flag2 == 1 {
                    
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    self.mapView.setRegion(region, animated: true)
                }else {
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = stringtext
                annotation.subtitle = "Unable to see detail"
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                print(stringtext)
                self.mapView.addAnnotation(annotation)
                self.mapView.selectAnnotation(annotation, animated: true)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
                
                }
            }
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


