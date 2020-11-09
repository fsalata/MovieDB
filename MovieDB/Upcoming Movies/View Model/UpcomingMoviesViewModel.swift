//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import Foundation
import UIKit

protocol UpcomingMoviesViewModelDelegate {
    func upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: UpcomingMoviesViewModel)
    func upcomingMoviesViewModel(viewModel: UpcomingMoviesViewModel, fetchMoviesFailedWithError error: NetworkError)
}

final class UpcomingMoviesViewModel {
    private var moviesService: MoviesService
    private var genresService: MovieGenresService
    
    var movies = [MovieViewModel]()
    var filteredMovies = [MovieViewModel]()
    
    var genres = [Genre]()
    
    var delegate: UpcomingMoviesViewModelDelegate?
    
    var currentPage = 1
    var totalPages: Int?
    
    private let dispatchGroup = DispatchGroup()
    
    private var error: NetworkError?
    
    init(moviesService: MoviesService = MoviesService(), genresService: MovieGenresService = MovieGenresService()) {
        self.moviesService = moviesService
        self.genresService = genresService
    }
    
    func fetchMovies() {
        error = nil
        
        if genres.isEmpty {
            fetchGenres()
        }
        
        fetchMovies(page: currentPage)
        
        guard error == nil else {
            delegate?.upcomingMoviesViewModel(viewModel: self, fetchMoviesFailedWithError: error!)
            return
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.delegate?.upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: self)
        }
    }
    
    private func fetchGenres() {
        dispatchGroup.enter()
        
        genresService.fetchMovieGenres { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.genres = data.genres
                
                self.dispatchGroup.leave()
                
            case .failure(let error):
                self.error = error
                self.dispatchGroup.leave()
            }
        }
    }
    
    private func fetchMovies(page: Int) {
        dispatchGroup.enter()
        
        moviesService.fetchUpcomingMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let results = data.results {
                    self.totalPages = data.totalPages
                    self.currentPage += 1
                    
                    self.movies += results.map {
                        return MovieViewModel(movie: $0, genres: self.genres)
                    }
                    
                    self.dispatchGroup.leave()
                }
                
            case .failure(let error):
                self.error = error
                self.currentPage = 1
                self.dispatchGroup.leave()
            }
        }
    }
}
