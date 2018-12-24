//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieHeaderView: MovieHeaderView!
    @IBOutlet weak var overview: UILabel!
    
    var movie: MovieViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //  MARK: Private methods
    private func setupView() {
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
        
        overview.text = movie.overview
    }
}
