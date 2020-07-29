//
//  MapOutputViewMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

@testable import meep_app

class MapOutputViewMock: MapOutputView {
    
    var valid = false
    var invalid = false
    
    func getTransports(transports: [Transport]) {
        valid = true
    }
    
    func getError(error: Error) {
        invalid = true
    }
    
    
}
