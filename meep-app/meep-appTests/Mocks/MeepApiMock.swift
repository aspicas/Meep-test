//
//  MeepApiMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit
@testable import meep_app

class MeepApiMock: MeepAPIProtocol {

    static var successState = false
    static var json: Any? = nil
    static var callError = CallError.serverError
    
    static func callService<T>(link: Link,
                               method: Methods,
                               service: Service,
                               params: Dictionary<String, String>?,
                               body: Dictionary<String, Any>?,
                               completion: @escaping (Result<T, CallError>) -> Void,
                               session: URLSession) where T : Decodable, T : Encodable {
        
        if successState {
            completion(Result.success(json != nil ? json! as! T : [] as! T))
        } else {
            completion(Result.failure(callError))
        }
    }
    
    
}
