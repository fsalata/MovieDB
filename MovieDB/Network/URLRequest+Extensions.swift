//
//  URLRequest+Extensions.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

extension URLRequest {
    init(baseURL: String, target: ServiceTargetProtocol) throws {
        var parameters = target.parameters ?? [:]
        
        parameters["api_key"] = ApiKey.value
        
        guard let url = URL(baseUrl: baseURL, path: target.path, parameters: parameters, method: target.method) else {
            throw NetworkError.Network.badURL
        }
        
        self.init(url: url)
        
        httpMethod = target.method.rawValue
        
        switch target.method {
        case .POST, .PUT:
            httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        default:
            break
        }
    }
}
