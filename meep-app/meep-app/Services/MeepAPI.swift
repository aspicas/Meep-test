//
//  MeepAPI.swift
//  meep-app
//
//  Created by David Garcia on 25/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//
import UIKit

public enum Methods: String {
    case get = "GET"
}

public enum Link: String {
    case baseURL = "https://apidev.meep.me/tripplan/api/v1"
}

public enum Service {
    case loadMap(lowerLeftLat: Double, lowerLeftLon: Double, upperRightLat: Double, upperRightLon: Double)
}

extension Service {
    var path: String {
        switch self {
        case .loadMap(let lowerLeftLat, let lowerLeftLon, let upperRightLat, let upperRightLon):
            return "/routers/lisboa/resources?lowerLeftLatLon=\(lowerLeftLat),\(lowerLeftLon)&upperRightLatLon=\(upperRightLat),\(upperRightLon)​"
        }
    }
}

public enum CallError: Error {
    case parseData
    case clientError
    case serverError
    case urlError
    case unknownError
    case noResponseError
    case noImage
}

class MeepAPI: MeepAPIProtocol {
    static func callService(link: Link,
                            method: Methods,
                            service: Service,
                            params: Dictionary<String, String>?,
                            body: Dictionary<String, Any>?,
                            completion: @escaping (Result<Dictionary<String, AnyObject>, CallError>) -> Void,
                            session: URLSession) {
        
        var urlComponents = URLComponents(string: link.rawValue + service.path)
        urlComponents?.queryItems = params?.map{ (arg) -> URLQueryItem  in
            let (key, value) = arg
            return URLQueryItem(name: key, value: value)
        }

        guard let url = urlComponents?.url, !url.absoluteString.isEmpty else {
            completion(Result.failure(CallError.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = method.rawValue
        if body != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body ?? [:], options: [])
        }
        
        MeepAPI.callAction(request: request,
                           session: session,
                           completion: completion) { data -> [String: AnyObject]? in
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                                print("response: \(json)")
                                return json
                            } catch {
                                return nil
                            }
                        }
        
    }
    
    static private func callAction<Success>(request: URLRequest,
                                            session: URLSession,
                                            completion: @escaping (_ result: Result<Success, CallError>) -> Void,
                                            action: @escaping (_ data: Data?) -> Success? ) {
        
        print("URL: \(String(describing: request.url))")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    guard let success = action(data) else {
                        completion(Result.failure(CallError.parseData))
                        return
                    }
                    completion(Result.success(success))
                    break;
                case 400...499:
                    print("error: \(CallError.clientError)")
                    completion(Result.failure(CallError.clientError))
                    break;
                case 500...599:
                    print("error: \(CallError.serverError)")
                    completion(Result.failure(CallError.serverError))
                    break;
                default:
                    print("error: \(CallError.unknownError)")
                    completion(Result.failure(CallError.unknownError))
                    break;
                }
            } else {
                print("error: \(CallError.noResponseError)")
                completion(Result.failure(CallError.noResponseError))
            }
        }
        
        task.resume()
    }
}
