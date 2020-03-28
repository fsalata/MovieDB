//
//  AppFlowController.swift
//  FlowController
//
//  Created by Fábio Salata on 28/03/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import UIKit

class AppFlowController: UIViewController {
    private let navigation = UINavigationController()
    
    func start() {
        let moviesFlowController = MoviesFlowController(navigation: navigation)
        
        navigation.viewControllers = [moviesFlowController]
        
        add(navigation)
        
        moviesFlowController.start()
    }
}
