//
//  Map+Extension.swift
//  meep-app
//
//  Created by David Garcia on 28/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}
