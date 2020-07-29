//
//  Pin.swift
//  meep-app
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var companyZoneId: Int
    
    var pinTintColor: UIColor {
        switch companyZoneId {
        case 402:
            return .red
        case 378:
            return .blue
        case 382:
            return .yellow
        case 467:
            return .purple
        case 473:
            return .green
        case 412:
            return .orange
        default:
            return .clear
        }
    }
    
    init(title: String, companyZoneId: Int, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.companyZoneId = companyZoneId
        
        super.init()
    }
}
