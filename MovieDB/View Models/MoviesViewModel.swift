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
    
    private let dispatchGroup = DispatchGroup()
    
    init(moviesService: MoviesService = MoviesService(), genresService: MovieGenresService = MovieGenresService()) {
        self.moviesService = moviesService
        self.genresService = genresService
    }
    
    func fetch(completion: @escaping () -> ()) {
        if genres.isEmpty {
            fetchGenres()
        }
        
        fetchMovies(page: currentPage)
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    fileprivate func fetchGenres() {
        dispatchGroup.enter()
        
        genresService.fetchMovieGenres { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.genres = data.genres
                self.error = nil
                
                self.dispatchGroup.leave()
                
            case .failure(let error):
                self.error = error
                
                self.dispatchGroup.leave()
            }
        }
    }
    
    fileprivate func fetchMovies(page: Int) {
        dispatchGroup.enter()
        
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
                    
                    self.dispatchGroup.leave()
                }
                
            case .failure(let error):
                self.error = error
                
                self.dispatchGroup.leave()
            }
        }
    }
}
