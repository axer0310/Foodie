//
//  File.swift
//  Foodie
//
//  Created by Smile. on 14/02/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

typealias ServiceResponse = (JSON, NSError?) -> Void
import Foundation
class testingAPI: NSObject {
static let sharedInstance = RestApiManager()

let baseURL = "http://api.randomuser.me/"

func getRandomUser(onCompletion: (JSON) -> Void) {
    let route = baseURL
    makeHTTPGetRequest(route, onCompletion: { json, err in
        onCompletion(json as JSON)
    })
}

func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
    let request = NSMutableURLRequest(URL: NSURL(string: path)!)
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        let json:JSON = JSON(data: data)
        onCompletion(json, error)
    })
    task.resume()
}
}
