//
//  pinAnnotationView.swift
//  MapLocator
//
//  Created by Student on 5/4/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import MapKit

class pinDetailView: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var category: String?
    var rating: UIView?
    var info: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, category: String, rating: UIView, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.category = category
        self.rating = rating
        self.info = info
    }
}