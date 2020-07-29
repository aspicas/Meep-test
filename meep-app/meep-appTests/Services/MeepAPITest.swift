//
//  MeepAPITest.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import XCTest
@testable import meep_app

class MeepAPITest: XCTestCase {
    
    private var session: URLSession!
    private var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        session = URLSession.init(configuration: configuration)
        expectation = expectation(description: "Test service call")
    }
    
    override func tearDown() {
        session = nil
        expectation = nil
    }
    
    //test[unit_of_work]_[scenario]_[expectedBehavior]
    func testLoapMap_SuccessMarketData_DownloadAllData() {
        let jsonString = """
                            [
                                {
                                    "id": "402:11059006",
                                    "name": "Rossio",
                                    "x": -9.1424,
                                    "y": 38.71497,
                                    "scheduledArrival": 0,
                                    "locationType": 0,
                                    "companyZoneId": 402,
                                    "lat": 38.71497,
                                    "lon": -9.1424
                                },
                                {
                                    "id": "378:M28",
                                    "name": "ROSSIO",
                                    "x": -9.13796,
                                    "y": 38.71402,
                                    "scheduledArrival": 0,
                                    "locationType": 0,
                                    "companyZoneId": 378,
                                    "lat": 38.71402,
                                    "lon": -9.13796
                                },
                                {
                                    "id": "378:M08",
                                    "name": "SÃO SEBASTIÃO",
                                    "x": -9.15365,
                                    "y": 38.734,
                                    "scheduledArrival": 0,
                                    "locationType": 0,
                                    "companyZoneId": 378,
                                    "lat": 38.734,
                                    "lon": -9.15365
                                }
                            ]
                         """
        
        let data = jsonString.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw CallError.urlError
            }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(let response):
                                    XCTAssertTrue(response.count == 3, "The response doesn't get all the data")
                                case .failure(let error):
                                    XCTFail("Error was not expected: \(error)")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoapMap_EmptyMarketData_GetEmptyValue() {
        let jsonString = """
                            []
                         """
        
        let data = jsonString.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw CallError.urlError
            }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(let response):
                                    XCTAssertTrue(response.count == 0, "The response doesn't get empty data")
                                case .failure(let error):
                                    XCTFail("Error was not expected: \(error)")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoapMap_Server400sError_HandleError() {
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw CallError.urlError
            }
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(_):
                                    XCTFail("Should not have response")
                                case .failure(let error):
                                    XCTAssertEqual(error, CallError.clientError, "No 400 error")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoapMap_Server500sError_HandleError() {
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw CallError.urlError
            }
            let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(_):
                                    XCTFail("Should not have response")
                                case .failure(let error):
                                    XCTAssertEqual(error, CallError.serverError, "No 500 error")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoapMap_UnknownError_HandleError() {
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw CallError.urlError
            }
            let response = HTTPURLResponse(url: url, statusCode: 100, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(_):
                                    XCTFail("Should not have response")
                                case .failure(let error):
                                    XCTAssertEqual(error, CallError.unknownError, "No Unknown error")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoapMap_NoResponse_HandleError() {
        URLProtocolMock.requestHandler = { _ in
            return (nil, nil)
        }
        
        MeepAPI.callService(link: .baseURL,
                            method: .get,
                            service: .loadMap,
                            body: nil,
                            completion: { (result: Result<[Transport], CallError>) in
                                switch result {
                                case .success(_):
                                    XCTFail("Should not have response")
                                case .failure(let error):
                                    XCTAssertEqual(error, CallError.noResponseError, "No URL error")
                                }
                                self.expectation.fulfill()
                            }, session: session)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
