//
//  MapInteractor.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import Foundation

class MapInteractor: MapInputInteractor {
    
    var presenter: MapOutputPresenter?
    
    init() {
        
    }
    
    init(presenter: MapOutputPresenter) {
        self.presenter = presenter
    }
    
    func fetchTransport(_ networkManagement: MeepAPIProtocol.Type = MeepAPI.self,
                        lowerLeftLat: Double, lowerLeftLon: Double,
                        upperRightLat: Double, upperRightLon: Double) {
        
        networkManagement.callService(link: .baseURL,
                                      method: .get,
                                      service: .loadMap(lowerLeftLat: lowerLeftLat, lowerLeftLon: lowerLeftLon,
                                                        upperRightLat: upperRightLat, upperRightLon: upperRightLon),
                                      params: nil,
                                      body: nil) { result in
            
                                        switch result {
                                        case .success(let json):
                                            guard json.count > 0 else {//}, let results = json["results"] as? [Dictionary<String, Any>] else {
                                                self.presenter?.handleTransportSuccess(transports: [])
                                                return
                                            }
                                            var transports: [Transport] = []
                                            //TODO: handle the change
                                            self.presenter?.handleTransportSuccess(transports: transports)
                                        case .failure(let error):
                                            self.presenter?.handleError(error: error)
                                        }
        }
    }
    
}
