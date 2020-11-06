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
    let id: Int
    let title: String
    let adult: Bool?
    let backdropPath, originalTitle: String?
    let genreIDS: [Int]?
    let voteAverage, popularity: Double?
    let posterPath, overview, originalLanguage: String?
    let voteCount: Int?
    let releaseDate: String?
    let video: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, adult
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case title, overview
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case video
    }
}
