//
//  URSExtension.swift
//  MovieDB
//
//  Created by Fabio Salata on 04/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path

        switch method {
        case .get, .delete:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }

        self = components.url!
    }
}
