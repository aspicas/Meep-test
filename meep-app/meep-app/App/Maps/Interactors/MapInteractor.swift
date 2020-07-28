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
        
        let params: Dictionary<String, String> = ["lowerLeftLat": "\(lowerLeftLat)",
                                                  "lowerLeftLon": "\(lowerLeftLon)",
                                                  "upperRightLat": "\(upperRightLat)",
                                                  "upperRightLon": "\(upperRightLon)"];
        
        networkManagement.callService(link: .baseURL,
                                      method: .get,
                                      service: .loadMap,
                                      params: params,
                                      body: nil) { (result : Result<[Transport], CallError>) in

                                        switch result {
                                        case .success(let transports):
                                            self.presenter?.handleTransportSuccess(transports: transports)
                                        case .failure(let error):
                                            self.presenter?.handleError(error: error)
                                        }
        }
    }
    
}
