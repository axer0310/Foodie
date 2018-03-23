//
//  Business.swift
//  Foodie
//
//  Created by Smile. on 20/02/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    let rating: Double?
    let phone: String?
    let id: String?
    let reviewwritten: String?
    var lat: Double?
    var long: Double?
    
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        id = dictionary["id"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        lat = 0.0
        long = 0.0
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let coordArray = location!["coordinate"] as? NSDictionary
//            print(location![4])[7][4]    (null)    "coordinate" : 2 key/value pairs        (null)    "display_address" : 2 elements
            print(coordArray!.count)
            if coordArray != nil && coordArray!.count > 1{
                    long = coordArray!.allValues[0] as! Double
                    lat = coordArray!.allValues[1] as! Double
                
            }
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        let ratingV = dictionary["rating"] as? Double
        if ratingV != nil {
            rating = ratingV
        } else {
            rating = nil
        }
        
        let phonenumber = dictionary["phone"] as? String
        if phonenumber != nil {
            phone = phonenumber
        } else {
            phone = nil
        }
        
        let reviewupper = dictionary["snippet_text"] as? String
//        var temp = ""
        if reviewupper != nil {
            reviewwritten = reviewupper
//            let reviewsArr = location!["reviews"] as? NSArray
//            if reviewsArr != nil && reviewsArr!.count > 0 {
//                temp = reviewsArr![0] as! String
//            }
////            reviews = storeids.joined(separator: "\n")
        }else{
            reviewwritten = nil
        }
//        self.reviews = temp
        
        print(rating!, phone ?? "" , reviewwritten ?? "")
        
//        print(reviews?)
       // print("some kind")
        
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    }
}
