//
//  ViewExtension.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func addBlurEffect() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.3
        
        visualEffectView.frame = self.bounds
        
        self.addSubview(visualEffectView)
        self.sendSubviewToBack(visualEffectView)
    }
}
