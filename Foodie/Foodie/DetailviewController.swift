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
    
    var infos:Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableName.text = infos?.name
        labelSub.text = infos?.address
        
        
    }
}
