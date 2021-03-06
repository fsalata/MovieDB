//
//  MovieDetailsCoordinator.swift
//  MovieDB
//
//  Created by Fábio Salata on 06/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

final class MovieDetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailsViewController = MovieDetailsViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
