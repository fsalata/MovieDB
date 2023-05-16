//
//  URLRequest+Extensions.swift
//  Counters
//

import Foundation

extension URLRequest {
    init(baseURL: String, target: ServiceTargetProtocol) throws {
        var parameters = target.parameters ?? [:]

        parameters["api_key"] = ApiKey.value

        guard let url = URL(baseUrl: baseURL, path: target.path, parameters: parameters, method: target.method) else {
            throw APIError.Network.badURL
        }

        self.init(url: url)

        httpMethod = target.method.rawValue

        switch target.method {
        case .POST, .PUT, .DELETE:
            httpBody = target.body
        default:
            break
        }
    }
}
