//
//  GenresService.swift
//  MovieDB
//
//  Created by Fabio Salata on 14/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

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
}

final class MovieGenresService {
    let client = APIClient()
    
    func fetchMovieGenres(completion: @escaping (Result<GenresModel, NetworkError>) -> Void) {
        client.request(target: GenresTarget.genres, completion: completion)
    }
}
