//
//  MapViewController.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    var presenter: MapInputPresenter?
    var transportArray: [Transport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.mapViewControllerTitle
        presenter?.fetchTransport(lowerLeftLat: 38.711046, lowerLeftLon: -9.160096, upperRightLat: 38.739429, upperRightLon: -9.137115)
    }
}

extension MapViewController: MapOutputView {
    func getTransports(transports: [Transport]) {
        transportArray = transports
    }
    
    func getError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.error,
                                          message: "\(Constants.problemFetchinNotice) \(error.localizedDescription)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.okay, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
