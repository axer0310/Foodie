//
//  HelpViewController.swift
//  Soil Explorer
//
//  Created by Arthur on 2017/10/5.
//  Copyright © 2017年 CERIS. All rights reserved.
//

import Foundation
import UIKit

class TutorialViewController:UIViewController,UIWebViewDelegate
{
    @IBOutlet var webView: UIWebView!
   
    override func viewDidLoad()
    {
        var url = Bundle.main.url(forResource: "Tutorial_total", withExtension: "pdf")
        self.webView.loadRequest(URLRequest.init(url: url!))
      
        self.webView.delegate=self
    }

}
