//
//  RestableviewControl.swift
//  Foodie
//
//  Created by Smile. on 08/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import UIKit

class LocationSearchTable : UITableViewController {
    var resultControl:UISearchController? = nil
    
    override func viewDidLoad() {
        let locationSearchT = storyboard!.instantiateViewController(withIdentifier: "location Search")
        resultControl = UISearchController(searchResultsController: locationSearchT)
        resultControl?.searchResultsUpdater = locationSearchT as? UISearchResultsUpdating
        let searchbar = resultControl!.searchBar
        searchbar.sizeToFit()
        searchbar.placeholder = "search"
        navigationItem.titleView = resultControl?.searchBar
        resultControl?.hidesNavigationBarDuringPresentation = false
        resultControl?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
}
