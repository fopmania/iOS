//
//  JunAnnotation.swift
//  myMap
//
//  Created by MAC on 2017-03-26.
//  Copyright © 2017 MAC. All rights reserved.
//

import MapKit

class JunAnnotation: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    
}
