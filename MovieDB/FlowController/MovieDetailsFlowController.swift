//
//  MovieDetailsFlowController.swift
//  MovieDB
//
//  Created by Fábio Salata on 28/03/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsFlowControler: FlowViewController {
    private var movie: MovieViewModel!
    
    convenience init(navigation: UINavigationController, movie: MovieViewModel) {
        self.init(navigation: navigation)
        self.movie = movie
    }
    
    override func start() {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movie
        
        add(movieDetailsViewController)
        
        title = "Movie details"
    }
}
