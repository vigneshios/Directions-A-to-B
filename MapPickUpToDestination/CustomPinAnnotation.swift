//
//  CustomPinAnnotation.swift
//  MapPickUpToDestination
//
//  Created by Apple on 12/03/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subTitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subTitle
    }
    
}
