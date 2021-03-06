//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Fabio Salata on 17/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import UIKit

struct MovieViewModel {
    let title: String
    let releaseDate: String
    let backdropURL: URL?
    let posterURL: URL?
    let genres: String
    let overview: String
    
    init(movie: Movie, genres: [Genre]) {
        
        self.title = movie.title
        
        self.releaseDate = movie.getFormattedReleaseDate()
        
        self.backdropURL = movie.getBackdropUrl()
        
        self.posterURL = movie.getPosterUrl()
        
        self.genres = movie.getGenresNames(from: genres)
        
        self.overview = movie.overview ?? ""
    }
}
