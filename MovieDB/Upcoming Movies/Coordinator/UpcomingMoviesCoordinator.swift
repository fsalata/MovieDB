//
//  HomeCoordinator.swift
//  MovieDB
//
//  Created by Fábio Salata on 06/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

final class UpcomingMoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var viewModel: UpcomingMoviesViewModel
    
    var movieDetailsCoordinator: MovieDetailsCoordinator!
    
    init(viewModel: UpcomingMoviesViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    func start() {
        let upcomingMoviesViewController = UpcomingMoviesViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(upcomingMoviesViewController, animated: true)
    }
}

extension UpcomingMoviesCoordinator {
    func presentMovieDetails(movie: MovieViewModel) {
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        
        let movieDetailsCoordinator = MovieDetailsCoordinator(viewModel: movieDetailsViewModel, navigationController: navigationController)
        movieDetailsCoordinator.start()
        self.movieDetailsCoordinator = movieDetailsCoordinator
    }
}
