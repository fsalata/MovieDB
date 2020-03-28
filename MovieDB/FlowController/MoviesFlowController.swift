//
//  MoviesFlowController.swift
//  MovieDB
//
//  Created by Fábio Salata on 28/03/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

class MoviesFlowController: FlowViewController {
    override func start() {
        let viewModel = MoviesViewModel()
        
        let moviesViewController = MoviesViewController(viewModel: viewModel)
        
        viewModel.delegate = self
        
        add(moviesViewController)
        
        title = "Upcoming movies"
    }
}

extension MoviesFlowController: MoviesViewModelDelegate {
    func setupSearchController(_ viewModel: MoviesViewModel, searchController: UISearchController) {
        navigationItem.searchController = searchController
    }
    
    func showMovieDetails(movie: MovieViewModel) {
        let movieDetailFlowController = MovieDetailsFlowControler(navigation: navigation, movie: movie)
        
        movieDetailFlowController.start()
        
        navigation.show(movieDetailFlowController, sender: self)
    }
}