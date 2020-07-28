//
//  MapRouter.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit

class MapRouter: MapInputRouter {
    static func createModule(storyboard: UIStoryboard = UIStoryboard(name: Constants.mapStoryboard, bundle: Bundle.main),
                             presenter: MapInputPresenter & MapOutputPresenter = MapPresenter(),
                             interactor: MapInputInteractor = MapInteractor(),
                             router: MapInputRouter = MapRouter()) -> UIViewController {
        
        let view = storyboard.instantiateViewController(identifier: Constants.mapViewControllerIdentifier) as! MapViewController
        
        let presenter: MapInputPresenter & MapOutputPresenter = presenter
        let interactor: MapInputInteractor = interactor
        let router: MapInputRouter = router
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    
}
