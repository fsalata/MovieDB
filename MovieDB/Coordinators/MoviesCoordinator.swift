//
//  MoviesCoordinator.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

class MoviesCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    
    private var moviesViewController: MoviesViewController?
    
    private var movieDetailsCoordinator: MovieDetailsCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MoviesViewModel()
        
        let moviesViewController = MoviesViewController(viewModel: viewModel)
        
        viewModel.delegate = self
        
        navigationController.delegate = self
        
        navigationController.pushViewController(moviesViewController, animated: true)
        
        self.moviesViewController = moviesViewController
    }
    
    func stop() {
        moviesViewController = nil
        movieDetailsCoordinator = nil
    }
}

extension MoviesCoordinator: MoviesViewModelDelegate {
    func showMovieDetails(movie: MovieViewModel) {
        let movieCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movie: movie)
        
        movieDetailsCoordinator = movieCoordinator
        
        movieCoordinator.start()
    }
}

extension MoviesCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        movieDetailsCoordinator?.stop()
        movieDetailsCoordinator = nil
    }
}
