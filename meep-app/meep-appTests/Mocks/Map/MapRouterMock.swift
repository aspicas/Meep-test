//
//  MapRouterMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit
@testable import meep_app

class MapRouterMock: MapInputRouter {
    static func createModule(storyboard: UIStoryboard, presenter: MapInputPresenter & MapOutputPresenter, interactor: MapInputInteractor, router: MapInputRouter) -> UIViewController {
        
        return UIViewController()
    }
}
