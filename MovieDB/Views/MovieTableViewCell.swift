//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var movieHeaderView: MovieHeaderView!
    
    var movie: MovieViewModel! {
        didSet {
            movieHeaderView.backdrop.image = UIImage(named: "backdropPlaceholder")
            
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    fileprivate func setupView() {
        self.selectionStyle = .none
        
        movieHeaderView = MovieHeaderView(frame: contentView.frame)
        movieHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(movieHeaderView)
        
        movieHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        movieHeaderView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        movieHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieHeaderView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        contentView.backgroundColor = UIColor(r: 42, g: 42, b: 42)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
