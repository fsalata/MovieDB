//
//  URLSessionProtocol.swift
//  MovieDB
//
//  Created by Fábio Salata on 12/02/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
