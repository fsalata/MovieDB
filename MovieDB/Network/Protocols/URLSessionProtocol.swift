//
//  URLSessionProtocol.swift
//  MovieDB
//
//  Created by Fábio Salata on 06/03/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation
import Combine

typealias APIResponse = URLSession.DataTaskPublisher.Output

protocol URLSessionProtocol {
    func erasedDataTaskPublisher(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: URLSessionProtocol {
    func erasedDataTaskPublisher(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
