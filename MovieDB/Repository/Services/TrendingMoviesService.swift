//
//  TrendingMoviesService.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

enum TrendingMoviesService: ServiceTargetProtocol {
    case trending(page: Int)
}

extension TrendingMoviesService {
    var path: String {
        "movie/popular"
    }

    var method: RequestMethod {
        .GET
    }

    var header: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var parameters: JSON? {
        var parameters: JSON = [:]
        
        switch self {
        case let .trending(page):
            parameters["page"] = "\(page)"
        }

        return parameters
    }

    var body: Data? {
        nil
    }
}
