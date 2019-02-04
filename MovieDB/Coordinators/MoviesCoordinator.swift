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
        let moviesViewController = MoviesViewController()
        moviesViewController.delegate = self
        
        navigationController.pushViewController(moviesViewController, animated: true)
        
        self.moviesViewController = moviesViewController
    }
}

extension MoviesCoordinator: MoviesViewControllerDelegate {
    func showMovieDetails(movie: MovieViewModel) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movie: movie)
        
        movieDetailsCoordinator.start()
    }
}
