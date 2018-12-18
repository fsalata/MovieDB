//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoView.addBlurEffect()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(_ cell: MovieTableViewCell, movie: MovieViewModel) {
        if let backdropPath = movie.backdropPath,
            let cachedImage = ImageCache.sharedInstance.cache.object(forKey: NSString(string: backdropPath.relativeString)) {
            cell.poster.image = cachedImage
        }
        else {
            cell.poster.image = UIImage(named: "backdropPlaceholder")
            if let backdropPath = movie.backdropPath {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: movie.backdropPath!) {
                        if let image = UIImage(data: imageData) {
                            ImageCache.sharedInstance.cache.setObject(image, forKey: NSString(string: backdropPath.relativeString))
                            
                            DispatchQueue.main.async {
                                cell.poster.image = image
                            }
                        }
                    }
                }
            }
        }
        
        cell.title.text = movie.title
        
        cell.genres.text = movie.genres
    
        cell.releaseDate.text =  movie.releaseDate
    }
}
