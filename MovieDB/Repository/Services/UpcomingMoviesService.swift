//
//  UpcomingMovieService.swift
//  MovieDB
//
//  Created by Fabio Salata on 04/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import Combine

enum UpcomingMoviesTarget: ServiceTargetProtocol {
    case upcoming(page: Int)
}

extension UpcomingMoviesTarget {
    var path: String {
        "movie/upcoming"
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
        case let .upcoming(page):
            parameters["page"] = "\(page)"
        }

        return parameters
    }

    var body: Data? {
        nil
    }
}
