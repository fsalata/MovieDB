//
//  DataLoading.swift
//  MovieDB
//
//  Created by Fabio Salata on 01/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

//TODO: Implement loading states on screens

protocol DataLoading {
    associatedtype Data
    
    var state: ViewState<Data> { get set }
    var loadingView: LoadingView { get }
    var errorView: ErrorView { get }
    
    func update()
}

enum ViewState<Content> {
    case loading
    case loaded(data: Content)
    case error(message: String)
}

extension DataLoading where Self: UIViewController {
    func update() {
        switch state {
        case .loading:
            loadingView.activityIndicator.startAnimating()
            loadingView.isHidden = false
            errorView.isHidden = true
            
        case .error(let error):
            loadingView.activityIndicator.stopAnimating()
            loadingView.isHidden = true
            errorView.isHidden = false
            errorView.message.text = error
            
        case .loaded:
            loadingView.activityIndicator.stopAnimating()
            loadingView.isHidden = true
            errorView.isHidden = true
        }
    }
}
