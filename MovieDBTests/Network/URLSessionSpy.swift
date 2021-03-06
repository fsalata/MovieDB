//
//  URLSessionSpy.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 12/02/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation
@testable import MovieDB

class URLSessionSpy: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return DummyURLSessionDataTask()
    }
}

class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        
    }
}
