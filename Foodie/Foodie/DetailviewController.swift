//
//  DetailviewController.swift
//  Foodie
//
//  Created by Smile. on 18/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import UIKit
import Firebase
class DetailviewController: UIViewController {
    
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var labelSub: UILabel!
    @IBOutlet var labelReview: UILabel!
    
    @IBOutlet var customRating: UITextField!
    @IBOutlet var ratings: UILabel!
    
    var infos:Food?
    var ref = Database.database().reference()
    var updateVal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableName.text = infos?.name
        labelSub.text = infos?.address
        if let review = infos?.reviewwritten
        {
            var buffer = review.components(separatedBy: "...")
            print(review)
            print(buffer[0])
            labelReview.text = buffer[0]
        }
        if let rating = infos?.rating
        {
            ratings.text =  "\(rating) / 5"
        }
        
        getRating()
        
    }
    
    @IBAction func sendRating(_ sender: Any)
    {
        getRating()
        customRating.resignFirstResponder()
        
    }
    func updateRating()
    {
        ratings.text = "\(updateVal) / 5"
    }

                    
                    
                }
                else
                {
                    if let customRating = self.customRating.text
                    {
                        if(customRating != "")
                        {
                            var customDoubleRating = Double(customRating)!
                            if(customDoubleRating > 5)
                            {
//                                customDoubleRating = 5.0
                                let alert = UIAlertView()
                                alert.title = "Exceed max rating number"
                                alert.message = "Please rate from 0 to 5"
                                alert.addButton(withTitle: "OK")
                                alert.show()
                            }
                            else
                            {
                                self.updateVal = (customDoubleRating + value!) / 2
                            }
                            
                        }
                        else
                        {
                            self.updateVal = value!
                        }
                        
                    }
                    else
                    {
                        self.updateVal = value!
                    }
                    
                }
                let childUpdates = ["/Restaurants/\(id)/Ratings": self.updateVal] as [String : Double]
                self.ref.updateChildValues(childUpdates)
                self.updateRating()
                
            })
        }
        
        
    }
}
