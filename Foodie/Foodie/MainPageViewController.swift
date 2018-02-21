//
//  MainPage.swift
//  Foodie
//
//  Created by Arthur on 2018/2/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainPageViewController: UIViewController
{
    var user = User()
    override func viewDidLoad()
    {
            print(user.name)
    }
    
    @IBAction func showRestaurant(_ sender: Any)
    {
        if let sb = UIStoryboard.init(name: "ResturantPage", bundle: nil) as? UIStoryboard
        {
            if let vc = sb.instantiateViewController(withIdentifier: "RestaurantView") as? ResturantViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func showChat(_ sender: Any)
    {
        if let sb = UIStoryboard.init(name: "Chat", bundle: nil) as? UIStoryboard
        {
            if let vc = sb.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
