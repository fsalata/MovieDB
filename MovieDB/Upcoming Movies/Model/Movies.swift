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

extension Movie {
    func getFormattedReleaseDate() -> String {
        return formatDateFrom(string: releaseDate)
    }
    
    func getGenresNames(from genres: [Genre]) -> String {
        guard let genreIDS = genreIDS else { return "" }
        
        let genres = genreIDS.compactMap{ id in
            return genres.first(where: { $0.id == id })?.name
        }
        
        return genres.joined(separator: ", ")
    }
    
    func getPosterUrl(urlDomain: String = API().posterURL) -> URL? {
        return getImageURL(path: posterPath, with: urlDomain)
    }
    
    func getBackdropUrl(urlDomain: String = API().backdropURL) -> URL? {
        return getImageURL(path: backdropPath, with: urlDomain)
    }
    
    private func getImageURL(path: String?, with domain: String) -> URL? {
        guard let path = path else {
            return nil
        }
        
        let url = URL(string: domain + path)
        
        return url
    }
    
    private static let dateFormatter = DateFormatter()
    
    private func formatDateFrom(string dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        
        Movie.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = Movie.dateFormatter.date(from: dateString) {
            Movie.dateFormatter.dateFormat = "dd/MM/yyyy"
            
            return Movie.dateFormatter.string(from: date)
        }
        
        return ""
    }
}
