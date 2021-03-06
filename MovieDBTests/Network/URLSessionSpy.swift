//
//  URLSessionSpy.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation
import Combine
@testable import MovieDB

class URLSessionSpy: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    var data: Data = Data()
    var response: HTTPURLResponse!
    var urlError: URLError!
    
    func erasedDataTaskPublisher(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        
        guard urlError == nil else {
            return Result.failure(urlError!).publisher.eraseToAnyPublisher()
        }
        
        return Result.success((data: data, response: response)).publisher.eraseToAnyPublisher()
    }
}
