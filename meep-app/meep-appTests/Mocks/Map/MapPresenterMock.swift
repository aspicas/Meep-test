//
//  MapPresenterMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

@testable import meep_app

class MapPresenterMock: MapInputPresenter, MapOutputPresenter {
    var view: MapOutputView?
    
    var interactor: MapInputInteractor?
    
    var router: MapInputRouter?
    
    var valid = false
    var invalid = false
    
    func fetchTransport(lowerLeftLat: Double, lowerLeftLon: Double, upperRightLat: Double, upperRightLon: Double) {
        
    }
    
    func handleTransportSuccess(transports: [Transport]) {
        valid = true
    }
    
    func handleError(error: Error) {
        invalid = true
    }
    
    
}
