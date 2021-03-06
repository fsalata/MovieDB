//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Fábio Salata on 06/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import Foundation

final class MovieDetailsViewModel {
    let movie: MovieViewModel
    
    init(movie: MovieViewModel) {
        self.movie = movie
    }
}
