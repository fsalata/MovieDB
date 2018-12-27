//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(r: 42, g: 42, b: 42)
        return scrollView
    } ()
    
    lazy var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    } ()
    
    var movieHeaderView: MovieHeaderView!
    
    var movie: MovieViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupLayout()
    }
    
    //  MARK: Private methods
    private func setupView() {
        title = "Movie details"
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(stackView)

        movieHeaderView = MovieHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 280.0))

        self.stackView.addArrangedSubview(movieHeaderView)
        
        fillMovieData()
    }
    
    fileprivate func setupLayout() {
        scrollView.anchor(top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor)
        scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width)
        
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        
        let overviewContainer = UIView()
        overviewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let overviewTitle = UILabel()
        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        overviewTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        overviewTitle.textColor = .white
        overviewTitle.text = "Overview"
        
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont(name: "HelveticaNeue", size: 13.0)
        overview.textColor = .white
        overview.numberOfLines = 0
        overview.text = movie.overview

        overviewContainer.addSubviews(overviewTitle, overview)
        
        overviewTitle.anchor(top: overviewContainer.topAnchor, left: overviewContainer.leftAnchor, bottom: overview.topAnchor, right: overviewContainer.rightAnchor, padding: .init(top: 15, left: 15, bottom: -8, right: -15))
        
        overview.anchor(top: nil, left: overviewContainer.leftAnchor, bottom: overviewContainer.bottomAnchor, right: overviewContainer.rightAnchor, padding: .init(top: 0, left: 15, bottom: -15, right: -15))
        
        stackView.addArrangedSubview(overviewContainer)
    }
    
    fileprivate func fillMovieData() {
        if let backdropPath = movie.backdropPath,
            let cachedImage = ImageCache.sharedInstance.cache.object(forKey: NSString(string: backdropPath.relativeString)) {
            movieHeaderView.backdrop.image = cachedImage
        }
        else {
            movieHeaderView.backdrop.image = UIImage(named: "backdropPlaceholder")
        }
        
        movieHeaderView.poster.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        movieHeaderView.poster.layer.borderWidth = 0.5
        movieHeaderView.poster.layer.cornerRadius = 5.0
        movieHeaderView.poster.clipsToBounds = true
        
        if let posterPath = movie.posterPath {
            movieHeaderView.poster.load(url: posterPath)
        }
        
        movieHeaderView.title.text = movie.title
        
        movieHeaderView.releaseDate.text = movie.releaseDate
        
        movieHeaderView.genres.text = movie.genres
    }
}
