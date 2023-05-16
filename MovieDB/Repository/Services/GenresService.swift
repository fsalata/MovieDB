//
//  GenresService.swift
//  MovieDB
//
//  Created by Fabio Salata on 14/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import Combine

enum GenresTarget: ServiceTargetProtocol {
    case genres
}

extension GenresTarget {
    var path: String {
        "genre/movie/list"
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
        return nil
    }

    var body: Data? {
        return nil
    }
}
