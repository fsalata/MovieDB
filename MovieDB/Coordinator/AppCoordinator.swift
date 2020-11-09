//
//  AppCoordinator.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var homeCoordinator: UpcomingMoviesCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = UpcomingMoviesViewModel()
        
        let homeCoordinator = UpcomingMoviesCoordinator(viewModel: viewModel, navigationController: navigationController)
        
        homeCoordinator.start()
        
        self.homeCoordinator = homeCoordinator
    }
}
