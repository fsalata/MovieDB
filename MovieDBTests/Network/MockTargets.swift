//
//  MockTargets.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 07/03/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation
@testable import MovieDB

enum MockMoviesTarget: ServiceTargetProtocol {
    case movies(page: Int)
}

extension MockMoviesTarget {
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
        case let .movies(page):
            parameters["page"] = "\(page)"
        }
        
        return parameters
    }
}

enum MockGenresPostTarget: ServiceTargetProtocol {
    case genres(genre: Genre)
}

extension MockGenresPostTarget {
    var path: String {
        "genres/add"
    }
    
    var method: RequestMethod {
        .POST
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
        case let .genres(genre):
            parameters["genre"] = "\(genre)"
        }
        
        return parameters
    }
}
