//
//  MapViewController.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    
    var presenter: MapInputPresenter?
    var transportArray: [Transport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.mapViewControllerTitle
//        startLoadingAnimation()
        stopLoadingAnimation()
        let initialLocation = CLLocation(latitude: 38.7437395, longitude: -9.2104151)
        mapView.centerToLocation(initialLocation, regionRadius: 20000)
//        presenter?.fetchTransport(lowerLeftLat: 38.711046, lowerLeftLon: -9.160096, upperRightLat: 38.739429, upperRightLon: -9.137115)
    }
    
    private func startLoadingAnimation(){
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func stopLoadingAnimation() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
}

extension MapViewController: MapOutputView {
    func getTransports(transports: [Transport]) {
        stopLoadingAnimation()
        transportArray = transports
    }
    
    func getError(error: Error) {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            let alert = UIAlertController(title: Constants.error,
                                          message: "\(Constants.problemFetchinNotice) \(error.localizedDescription)",
                preferredStyle: .alert)
            
            let reloadaction = UIAlertAction(title: Constants.reload, style: .default) { _ in
                self.startLoadingAnimation()
                self.presenter?.fetchTransport(lowerLeftLat: 38.711046, lowerLeftLon: -9.160096, upperRightLat: 38.739429, upperRightLon: -9.137115)
            }
            
            let cancelaction = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
            
            alert.addAction(reloadaction)
            alert.addAction(cancelaction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

