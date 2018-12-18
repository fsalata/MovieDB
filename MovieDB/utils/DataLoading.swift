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
    var loadingView: UIView { get }
    var errorView: UIView { get }
    
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
            loadingView.isHidden = false
            errorView.isHidden = true
            
        case .error(let error):
            loadingView.isHidden = true
            errorView.isHidden = false
            print(error)
            
        case .loaded(let data):
            loadingView.isHidden = true
            errorView.isHidden = true
            print(data)
        }
    }
}
