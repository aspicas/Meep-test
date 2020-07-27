//
//  MapProtocols.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit

protocol MapInputPresenter: class {
    var view: MapOutputView? {get set}
    var interactor: MapInputInteractor? {get set}
    var router: MapInputRouter? {get set}
    
    func fetchTransport(lowerLeftLat: Double, lowerLeftLon: Double,
                        upperRightLat:Double, upperRightLon:Double)
}

protocol MapOutputView: class {
    func getTransports(transports: [Transport])
    func getError(error: Error)
}

protocol MapInputRouter: class {
    static func createModule(storyboard: UIStoryboard,
                             presenter: MapInputPresenter & MapOutputPresenter,
                             interactor: MapInputInteractor,
                             router: MapInputRouter) -> UIViewController
}

protocol MapInputInteractor: class {
    var presenter: MapOutputPresenter? {get set}
    
    func fetchTransport(_ networkManagement: MeepAPIProtocol.Type,
                        lowerLeftLat: Double, lowerLeftLon: Double,
                        upperRightLat:Double, upperRightLon:Double)
    
    func fetchTransport(lowerLeftLat: Double, lowerLeftLon: Double,
                        upperRightLat:Double, upperRightLon:Double)
}

extension MapInputInteractor {
    func fetchTransport(lowerLeftLat: Double, lowerLeftLon: Double, upperRightLat:Double, upperRightLon:Double) {
        fetchTransport(MeepAPI.self,
                       lowerLeftLat: lowerLeftLat, lowerLeftLon: lowerLeftLon,
                       upperRightLat: upperRightLat, upperRightLon: upperRightLon)
    }
}

protocol MapOutputPresenter: class {
    func handleTransportSuccess(transports: [Transport])
    func handleError(error: Error)
}
