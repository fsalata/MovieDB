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
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    var formattedDate: String?
    var formattedGenres: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
