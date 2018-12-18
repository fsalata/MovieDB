//
//  Movies.swift
//  MovieDB
//
//  Created by Fabio Salata on 11/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

struct MoviesModel: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable {
    let id: Int?
    let title: String
    let posterPath: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
}
