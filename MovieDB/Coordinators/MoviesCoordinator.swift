//
//  MoviesCoordinator.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var moviesViewController: MoviesViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MoviesViewModel()
        
        let moviesViewController = MoviesViewController(viewModel: viewModel)
        
        viewModel.delegate = self
        
        navigationController.pushViewController(moviesViewController, animated: true)
        
        self.moviesViewController = moviesViewController
    }
    
    func stop() {
        moviesViewController = nil
    }
}

extension MoviesCoordinator: MoviesViewModelDelegate {
    func showMovieDetails(movie: MovieViewModel) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movie: movie)
        
        movieDetailsCoordinator.start()
    }
}
