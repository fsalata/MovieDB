//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import Foundation
import UIKit

final class MoviesViewModel {
    var movies = [MovieViewModel]()
    var filteredMovies = [MovieViewModel]()
    
    var genres = [Genre]()
    
    var currentPage = 1
    var totalPages: Int?
    
    var error: ServiceError?
    
    private var moviesService: MoviesService
    private var genresService: MovieGenresService
    
    init(moviesService: MoviesService, genresService: MovieGenresService) {
        self.moviesService = moviesService
        self.genresService = genresService
    }
    
    func fetch(completion: @escaping () -> ()) {
        if genres.count == 0 {
            genresService.fetchMovieGenres { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.genres = data.genres
                    self.error = nil
                    
                    self.fetchMovies(page: self.currentPage) {
                        completion()
                    }
                    
                case .failure(let error):
                    self.error = error
                    completion()
                }
            }
        }
        else {
            self.fetchMovies(page: self.currentPage) {
                completion()
            }
        }
    }
    
    func fetchMovies(page: Int, completion: @escaping () -> ()) {
        moviesService.fetchUpcomingMovies(page: page) { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let results = data.results {
                    self.totalPages = data.totalPages
                    
                    self.movies += results.map {
                        return MovieViewModel(movie: $0, genres: self.genres)
                    }
                    
                    self.error = nil
                    
                    completion()
                }
                
            case .failure(let error):
                self.error = error
                completion()
            }
        }
    }
}
