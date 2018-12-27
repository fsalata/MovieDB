//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    var movieHeaderView: MovieHeaderView!
    
    var movie: MovieViewModel! {
        didSet {
            if let backdropPath = movie.backdropPath {
                if let cachedImage = ImageCache.sharedInstance.cache.object(forKey: NSString(string: backdropPath.absoluteString)) {
                    movieHeaderView.backdrop.image = cachedImage
                }
                else {
                    movieHeaderView.backdrop.load(url: backdropPath)
                }
            }
            
            movieHeaderView.title.text = movie.title
            
            movieHeaderView.genres.text = movie.genres
            
            movieHeaderView.releaseDate.text =  movie.releaseDate
            
            if let posterPath = movie.posterPath {
                movieHeaderView.poster.load(url: posterPath)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        setupLayout()
    }
    
    fileprivate func setupView() {
        movieHeaderView = MovieHeaderView(frame: contentView.frame)
        
        contentView.addSubview(movieHeaderView)
    
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = UIColor.clear
    }
    
    fileprivate func setupLayout() {
        movieHeaderView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
    }
    
    override func prepareForReuse() {
        let imagePlaceholder = UIImage(named: "backdropPlaceholder")
        
        movieHeaderView.backdrop.image = imagePlaceholder
        
        movieHeaderView.poster.image = imagePlaceholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
