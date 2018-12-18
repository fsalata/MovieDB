//
//  APIClient.swift
//  MovieDB
//
//  Created by Fabio Salata on 02/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

final class WebClient {

    func load(path: String, method: RequestMethod, params: JSON?, completion: @escaping (Data?, ServiceError?) -> ()) -> URLSessionDataTask? {
        
        var parameters: JSON = [String: Any]()
        
        if let params = params {
            parameters = params
        }
        
        parameters["api_key"] = ApiKey.key
        
        let request = URLRequest(baseUrl: Domains.baseURL, path: path, method: method, params: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                if let data = data {
                    completion(data, nil)
                }
            } else {
                // TODO: Better error handling
                var object: Any?
                if let data = data {
                    object = try? JSONSerialization.jsonObject(with: data, options: [])
                }
    
                let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
    
                completion(nil, error)
            }
        }

        task.resume()

        return task
    }
}
