//
//  AppFlowController.swift
//  FlowController
//
//  Created by Fábio Salata on 28/03/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import UIKit

class AppFlowController: UIViewController, FlowController {
    var navigation: UINavigationController
    
    required init(navigation: UINavigationController) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        navigation = UINavigationController()
        
        let moviesFlowController = MoviesFlowController(navigation: navigation)
        
        navigation.viewControllers = [moviesFlowController]
        
        add(navigation)
        
        moviesFlowController.start()
    }
}
