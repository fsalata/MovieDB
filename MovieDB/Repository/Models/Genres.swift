//
//  MoviesGenre.swift
//  MovieDB
//
//  Created by Fabio Salata on 14/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

final class GenresResult: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
