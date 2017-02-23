//
//  Pin.swift
//  Found
//
//  Created by Justin Vasselli on 4/25/16.
//  Copyright © 2016 Justin Vasselli. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(newLocation: CLLocationCoordinate2D, withName name: String) {
        coordinate = newLocation
        title = name
    }
}