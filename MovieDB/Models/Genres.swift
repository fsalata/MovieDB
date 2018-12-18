//
//  MoviesGenre.swift
//  MovieDB
//
//  Created by Fabio Salata on 14/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

final class GenresModel: Codable {
    let genres: [Genre]
}

final class Genre: Codable {
    let id: Int
    let name: String
}
