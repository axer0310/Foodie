//
//  QRViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
import UIKit

class QRViewController : UIViewController
{
    var qrImage = UIImage()
    @IBOutlet var QRView: UIImageView!
    override func viewDidLoad()
    {
        self.QRView.image = qrImage
    }
    
}
