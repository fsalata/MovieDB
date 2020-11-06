//
//  UIViewControllerExtension.swift
//  MovieDB
//
//  Created by Fábio Salata on 28/03/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.pinEdgesToSuperview()
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
