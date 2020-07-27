//
//  MapPresenter.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import Foundation

class MapPresenter: MapInputPresenter {
    
    var view: MapOutputView?
    
    var interactor: MapInputInteractor?
    
    var router: MapInputRouter?
    
    init() {
        
    }
    
    init(view: MapOutputView,
         interactor: MapInputInteractor,
         router: MapInputRouter) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor?.presenter = self
    }
    
    func fetchTransport(lowerLeftLat: Double, lowerLeftLon: Double, upperRightLat: Double, upperRightLon: Double) {
        interactor?.fetchTransport(lowerLeftLat: lowerLeftLat, lowerLeftLon: lowerLeftLon, upperRightLat: upperRightLat, upperRightLon: upperRightLon)
    }
    
}

extension MapPresenter: MapOutputPresenter {
    func handleTransportSuccess(transports: [Transport]) {
        view?.getTransports(transports: transports)
    }
    
    func handleError(error: Error) {
        view?.getError(error: error)
    }
    
    
}
