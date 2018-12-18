//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
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
            backdrop.image = cachedImage
        }
        else {
            backdrop.image = UIImage(named: "backdropPlaceholder")
        }
        
        self.poster.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        self.poster.layer.borderWidth = 0.5
        self.poster.layer.cornerRadius = 5.0
        self.poster.clipsToBounds = true
        
        if let posterPath = movie.posterPath {
            self.poster.load(url: posterPath)
        }
        
        movieTitle.text = movie.title
        
        releaseDate.text = movie.releaseDate
        
        genres.text = movie.genres
        
        overview.text = movie.overview
    }
}
