//
//  APIClient.swift
//  MovieDB
//
//  Created by Fabio Salata on 02/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import Network

typealias JSON = [String: Any]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

final class WebClient {
    let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
    var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    func load(path: String, method: RequestMethod, params: JSON?, completion: @escaping (Result<Data, ServiceError>) -> ()) -> URLSessionDataTask? {
        
        guard isConnected else {
            completion(Result.failure(ServiceError.noInternetConnection))
            return nil
        }
        
        var parameters: JSON = [String: Any]()
        
        if let params = params {
            parameters = params
        }
        
        parameters["api_key"] = ApiKey.value
        
        let request = URLRequest(baseUrl: Domains.baseURL, path: path, method: method, params: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                if let data = data {
                    completion(Result.success(data))
                }
            } else {
                var object: Any?
                if let data = data {
                    object = try? JSONSerialization.jsonObject(with: data, options: [])
                }
    
                let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
    
                completion(Result.failure(error))
            }
        }

        task.resume()

        return task
    }
}
