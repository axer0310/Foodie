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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableName.text = storename
        labelSub.text = sub
        
        
        
        
    }
}
