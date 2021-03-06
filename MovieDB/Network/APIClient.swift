//
//  APIClient.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation
import Combine

class APIClient {
    private var session: URLSessionProtocol
    private var api: APIProtocol
    
    init(session: URLSession = URLSession.shared,
         api: APIProtocol = API()) {
        self.session = session
        self.api = api
    }
    
    func request<T: Decodable>(target: ServiceTargetProtocol) -> AnyPublisher<T, APIError> {
        guard var urlRequest = try? URLRequest(baseURL: api.baseURL, target: target) else {
            return Fail(error: APIError.network(.badURL)).eraseToAnyPublisher()
        }
        
        urlRequest.allHTTPHeaderFields = target.header
        
        return session.dataTaskPublisher(for: urlRequest)
            .retry(1)
            .debugResponse(request: urlRequest)
            .extractData()
            .decode()
            .mapError { error in
                return error as? APIError ?? APIError.unknown
            }
            .eraseToAnyPublisher()
    }
}

