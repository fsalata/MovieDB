//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
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
    }
    
    fileprivate func setupView() {
        movieHeaderView = MovieHeaderView(frame: contentView.frame)
        movieHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(movieHeaderView)
        
        movieHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieHeaderView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        movieHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieHeaderView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        
        contentView.backgroundColor = UIColor(r: 42, g: 42, b: 42)
    }
    
    override func prepareForReuse() {
        let imagePlaceholder = UIImage(named: "backdropPlaceholder")
        
        movieHeaderView.backdrop.image = imagePlaceholder
        
        movieHeaderView.title.text = ""
        
        movieHeaderView.genres.text = ""
        
        movieHeaderView.releaseDate.text =  ""
        
        movieHeaderView.poster.image = imagePlaceholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
