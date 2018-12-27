//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var scrollView: UIScrollView!
    
    var movieHeaderView: MovieHeaderView!
    
    var movie: MovieViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //  MARK: Private methods
    private func setupView() {
        setupLayout()
        
        
//        if let backdropPath = movie.backdropPath,
//            let cachedImage = ImageCache.sharedInstance.cache.object(forKey: NSString(string: backdropPath.relativeString)) {
//            movieHeaderView.backdrop.image = cachedImage
//        }
//        else {
//            movieHeaderView.backdrop.image = UIImage(named: "backdropPlaceholder")
//        }
//
//        movieHeaderView.poster.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
//        movieHeaderView.poster.layer.borderWidth = 0.5
//        movieHeaderView.poster.layer.cornerRadius = 5.0
//        movieHeaderView.poster.clipsToBounds = true
//
//        if let posterPath = movie.posterPath {
//            movieHeaderView.poster.load(url: posterPath)
//        }
//
//        movieHeaderView.title.text = movie.title
//
//        movieHeaderView.releaseDate.text = movie.releaseDate
//
//        movieHeaderView.genres.text = movie.genres
//
//        overview.text = movie.overview
    }
    
    private func setupLayout() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(r: 42, g: 42, b: 42)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        scrollView.pinEdgesToSuperview()
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinEdgesToSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        contentView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        movieHeaderView = MovieHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: contentView.frame.width, height: 280))
        contentView.addSubview(movieHeaderView)
        
        movieHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieHeaderView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        movieHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieHeaderView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        
//        let overviewContainer = UIView()
//        contentView.addSubview(overviewContainer)
//
//        overviewContainer.topAnchor.constraint(equalTo: movieHeaderView.bottomAnchor).isActive = true
//        overviewContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        overviewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        overviewContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//
//        let overviewTitle = UILabel()
//        overviewTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
//        overviewTitle.textColor = .white
//        overviewTitle.text = "Overview"
//        overviewContainer.addSubview(overviewTitle)
//
//        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
//        overviewTitle.topAnchor.constraint(equalTo: overviewContainer.topAnchor, constant: 15.0).isActive = true
//        overviewTitle.rightAnchor.constraint(equalTo: overviewContainer.rightAnchor, constant: 15.0).isActive = true
//        overviewTitle.bottomAnchor.constraint(equalTo: overviewContainer.bottomAnchor, constant: 15.0).isActive = true
//        overviewTitle.leftAnchor.constraint(equalTo: overviewContainer.leftAnchor, constant: 15.0).isActive = true
//
//        scrollView.contentSize = contentView.frame.size
    }
}
