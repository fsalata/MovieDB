//
//  MovieDetailsCoordinator.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    private var movieDetailsViewController: MovieDetailsViewController?
    
    private var movie: MovieViewModel
    
    init(navigationController: UINavigationController, movie: MovieViewModel) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movie
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
        
        self.movieDetailsViewController = movieDetailsViewController
    }
    
}
