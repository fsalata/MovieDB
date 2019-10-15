//
//  LoadingView.swift
//  MovieDB
//
//  Created by Fabio Salata on 05/01/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        setupView()
    }
    
    // MARK - Private methods
    private func setupLayout() {
        self.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
