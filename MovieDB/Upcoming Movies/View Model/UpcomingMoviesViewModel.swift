//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit
import Combine

protocol UpcomingMoviesViewModelDelegate {
    func upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: UpcomingMoviesViewModel)
    func upcomingMoviesViewModel(viewModel: UpcomingMoviesViewModel, fetchMoviesFailedWithError error: APIError)
}

final class UpcomingMoviesViewModel {
    private var moviesService: MoviesService
    private var genresService: MovieGenresService
    
    var movies = [MovieViewModel]()
    var filteredMovies = [MovieViewModel]()
    
    var genres: [Genre]?
    
    var subscribers = Set<AnyCancellable>()
    
    var delegate: UpcomingMoviesViewModelDelegate?
    
    var currentPage = 1
    var totalPages: Int?
    
    private let dispatchGroup = DispatchGroup()
    
    private var error: APIError?
    
    init(moviesService: MoviesService = MoviesService(), genresService: MovieGenresService = MovieGenresService()) {
        self.moviesService = moviesService
        self.genresService = genresService
    }
    
    func fetchMovies() {
        if self.genres == nil {
            moviesService.fetchUpcomingMovies(page: currentPage)
                .zip(genresService.fetchMoviesGenres())
                .receive(on: DispatchQueue.main)
                .sink {[weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                } receiveValue: {[weak self] moviesData, genresData in
                    guard let self = self else { return }
                    
                    self.genres = genresData.genres
                    
                    if let results = moviesData.results {
                        self.totalPages = moviesData.totalPages
                        self.currentPage += 1
                        
                        self.movies += results.map {
                            return MovieViewModel(movie: $0, genres: self.genres ?? [Genre]())
                        }
                        
                        self.delegate?.upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: self)
                    }
                }
                .store(in: &subscribers)
        } else {
            moviesService.fetchUpcomingMovies(page: currentPage)
                .sink {[weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                } receiveValue: {[weak self] moviesData in
                    guard let self = self else { return }
                    
                    if let results = moviesData.results {
                        self.totalPages = moviesData.totalPages
                        self.currentPage += 1
                        
                        self.movies += results.map {
                            return MovieViewModel(movie: $0, genres: self.genres ?? [Genre]())
                        }
                        
                        self.delegate?.upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: self)
                    }
                }
                .store(in: &subscribers)
        }
    }
}
