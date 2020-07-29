//
//  MapInteractorTest.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import XCTest
@testable import meep_app

class MapInteractorTest: XCTestCase {
    
    var interactor: MapInteractor!
    var presenter: MapPresenterMock!
    
    override func setUp() {
        presenter = MapPresenterMock()
        interactor = MapInteractor(presenter: presenter)
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
        MeepApiMock.callError = .serverError
        MeepApiMock.successState = false
        MeepApiMock.json = nil
    }
    
    func testFetch_GetDataFromService_UseRightPresenter() {
        MeepApiMock.successState = true
        MeepApiMock.json = [Transport]()
        interactor.fetchTransport(MeepApiMock.self, lowerLeftLat: 0, lowerLeftLon: 0, upperRightLat: 0, upperRightLon: 0)
        XCTAssertTrue(presenter.valid, "Invalid presenter")
    }
    
    func testHandleError_GetErrorFromService_UseRightPresenter() {
        interactor.fetchTransport(MeepApiMock.self, lowerLeftLat: 0, lowerLeftLon: 0, upperRightLat: 0, upperRightLon: 0)
        XCTAssertTrue(presenter.invalid, "Invalid presentter")
    }
}
