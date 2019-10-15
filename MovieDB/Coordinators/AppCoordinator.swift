//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by Fabio Cezar Salata on 04/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var moviesCoordinator: MoviesCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        
        moviesCoordinator.start()
        
        self.moviesCoordinator = moviesCoordinator
    }
    
    func stop() {
        moviesCoordinator = nil
    }
}
