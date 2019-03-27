//
//  EventController.swift
//  SLIApp
//
//  Created by Chandler Long on 6/26/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventController: UIViewController, CLLocationManagerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cistern Yard Dance"
        view.addSubview(EventDetailsView(frame: view.frame))
        
    }
    
}
