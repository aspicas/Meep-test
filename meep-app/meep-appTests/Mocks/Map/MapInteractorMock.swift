//
//  MapInteractorMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

@testable import meep_app

class MapInteractorMock: MapInputInteractor {
    
    var presenter: MapOutputPresenter?
    
    func fetchTransport(_ networkManagement: MeepAPIProtocol.Type, lowerLeftLat: Double, lowerLeftLon: Double, upperRightLat: Double, upperRightLon: Double) {
        
    }

}
