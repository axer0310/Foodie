//
//  DetailviewController.swift
//  Foodie
//
//  Created by Smile. on 18/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import UIKit

class DetailviewController: UIViewController {
    
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var labelSub: UILabel!
    
    var storename = ""
    var sub = ""
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableName.text = storename
        labelSub.text = sub
        YelpClient.fetchReviews(forBusinessId: id){
            if let response = response,
                let reviews = response.reviews,
                reviews.count > 0 {
                print(reviews)
            }
            
        }
        
    }
    public func fetchReviews(forBusinessId id: String!, // Required
        completion: @escaping (CDReview?) -> Void)
}
