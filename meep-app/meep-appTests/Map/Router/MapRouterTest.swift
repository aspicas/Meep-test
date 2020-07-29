//
//  MapRouterTest.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import XCTest
@testable import meep_app

class MapRouterTest: XCTestCase {

    private var router: MapRouter!
    
    override func setUp() {
        router = MapRouter()
    }
    
    override func tearDown() {
        router = nil
    }
    
    func testModule_CreateModule_GetTheRightPresenter() {
        let controller = MapRouter.createModule(storyboard: UIStoryboardMock(),
                                                    presenter: MapPresenterMock(),
                                                    interactor: MapInteractorMock(),
                                                    router: router)
        
        XCTAssert(controller is MapViewControllerMock, "The controller is wrong")
        let resultClass = controller as! MapViewControllerMock
        XCTAssertTrue(resultClass.presenter != nil)
    }
    
}
