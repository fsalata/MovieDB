//
//  ErrorView.swift
//  MovieDB
//
//  Created by Fabio Salata on 05/01/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    lazy var message: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        setupView()
    }
    
    // MARK - Private methods
    fileprivate func setupLayout() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        containerView.addSubviews(message, button)
        
        message.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor)
        button.anchor(top: message.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, padding: .init(top: 15.0, left: 0, bottom: 0, right: 0 ))
        
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
