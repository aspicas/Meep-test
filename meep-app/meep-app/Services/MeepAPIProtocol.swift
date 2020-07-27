//
//  MeepAPIProtocol.swift
//  meep-app
//
//  Created by David Garcia on 25/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import Foundation

protocol MeepAPIProtocol {
    static func callService(link: Link,
                            method: Methods,
                            service: Service,
                            params: Dictionary<String, String>?,
                            body: Dictionary<String, Any>?,
                            completion: @escaping (_ result: Result<Dictionary<String, AnyObject>, CallError>) -> Void,
                            session: URLSession) -> Void
    
    static func callService(link: Link,
                            method: Methods,
                            service: Service,
                            params: Dictionary<String, String>?,
                            body: Dictionary<String, Any>?,
                            completion: @escaping (_ result: Result<Dictionary<String, AnyObject>, CallError>) -> Void) -> Void
}

extension MeepAPIProtocol {
    static func callService(link: Link,
                            method: Methods,
                            service: Service,
                            params: Dictionary<String, String>?,
                            body: Dictionary<String, Any>?,
                            completion: @escaping (_ result: Result<Dictionary<String, AnyObject>, CallError>) -> Void) -> Void {
        
        callService(link: link, method: method, service: service, params: params,
                    body: body, completion: completion, session: URLSession.shared)
    }
}
