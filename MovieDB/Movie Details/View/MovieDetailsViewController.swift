//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    var coordinator: MovieDetailsCoordinator!
    var viewModel: MovieDetailsViewModel!
    
    
    lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(r: 2, g: 34, b: 67)
        return scrollView
    } ()
    
    lazy var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    } ()
    
    var movieHeaderView: MovieHeaderView!
    
    init(viewModel: MovieDetailsViewModel, coordinator: MovieDetailsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieHeaderView.fillWith(viewModel.movie)
    }
    
    // MARK: View and Layout
    
    private func setupLayout() {
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(stackView)
        
        movieHeaderView = MovieHeaderView(frame: .init(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 280.0))
        
        self.stackView.addArrangedSubview(movieHeaderView)
        
        scrollView.anchor(top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor)
        scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let overviewContainer = UIView()
        overviewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let overviewTitle = UILabel()
        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        overviewTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        overviewTitle.textColor = .white
        overviewTitle.text = "Overview"
        overviewTitle.backgroundColor = UIColor(r: 2, g: 34, b: 67)
        
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont(name: "HelveticaNeue", size: 13.0)
        overview.textColor = .white
        overview.numberOfLines = 0
        overview.text = viewModel.movie.overview
        overview.backgroundColor = UIColor(r: 2, g: 34, b: 67)

        overviewContainer.addSubviews(overviewTitle, overview)
        
        overviewTitle.anchor(top: overviewContainer.topAnchor, left: overviewContainer.leftAnchor, bottom: overview.topAnchor, right: overviewContainer.rightAnchor, padding: .init(top: 15, left: 15, bottom: -8, right: -15))
        
        overview.anchor(top: nil, left: overviewContainer.leftAnchor, bottom: overviewContainer.bottomAnchor, right: overviewContainer.rightAnchor, padding: .init(top: 0, left: 15, bottom: -15, right: -15))
        
        stackView.addArrangedSubview(overviewContainer)
    }
}
