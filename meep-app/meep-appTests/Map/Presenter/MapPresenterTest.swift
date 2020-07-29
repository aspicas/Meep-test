//
//  MapPresenterTest.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import XCTest
@testable import meep_app

class MapPresenterTest: XCTestCase {

    var presenter: MapPresenter!
    var view: MapOutputViewMock!
    var interactor: MapInteractorMock!
    var router: MapRouterMock!
    
    override func setUp() {
        view = MapOutputViewMock()
        interactor = MapInteractorMock()
        router = MapRouterMock()
        
        presenter = MapPresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    func testFetch_SettingInteractor_UseTheRightInteractor() {
        presenter.fetchTransport(lowerLeftLat: 0, lowerLeftLon: 0, upperRightLat: 0, upperRightLon: 0)
        XCTAssertTrue(interactor.isFetch, "Doesn't use the right interactor")
    }
    
    func testGetData_SettingView_UserTheRightView() {
        presenter.handleTransportSuccess(transports: [])
        XCTAssertTrue(view.valid, "The view doesn't handle the call service")
    }
    
    func testGetError_SettingView_UserTheRightView() {
        presenter.handleError(error: CallError.serverError)
        XCTAssertTrue(view.invalid, "The view doesn't handle the error")
    }

}
