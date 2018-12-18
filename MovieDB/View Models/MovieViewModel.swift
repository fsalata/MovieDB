//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Fabio Salata on 17/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

struct MovieViewModel {
    let title: String
    let releaseDate: String
    let backdropPath: URL?
    let posterPath: URL?
    let genres: String
    let overview: String
    
    init(movie: Movie, genres: [Genre]) {
        
        self.title = movie.title
        
        self.releaseDate = MovieViewModel.formatDateFrom(string: movie.releaseDate) ?? ""
        
        self.backdropPath = movie.backdropPath != nil ? URL(string: Domains.backdropURL + movie.backdropPath!) : nil
        
        self.posterPath = movie.posterPath != nil ? URL(string: Domains.posterURL + movie.posterPath!) : nil
        
        self.genres = MovieViewModel.formatGenres(movie.genreIDS, genres: genres) ?? ""
        
        self.overview = movie.overview ?? ""
    }
    
    fileprivate static func formatDateFrom(string dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date!)
    }
    
   fileprivate static func formatGenres(_ genresIDS: [Int]?, genres: [Genre]) -> String? {
    guard let genresIDS = genresIDS else { return nil }
    
        let genres = genresIDS.compactMap{ id in
            return genres.first(where: { $0.id == id })?.name ?? nil
        }
        
        return genres.joined(separator: ", ")
    }
}
