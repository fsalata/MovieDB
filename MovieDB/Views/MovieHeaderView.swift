//
//  MovieHeaderView.swift
//  MovieDB
//
//  Created by Fabio Salata on 24/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieHeaderView: UIView {
    
    lazy var backdrop: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "backdropPlaceholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var poster: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "backdropPlaceholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieInfo: UIView! = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        return view
    }()
    
    lazy var title: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .black
        return label
    }()
    
    lazy var releaseDate: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    lazy var genres: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SDWebImageManager.shared().delegate = self
        
        setupView()
        
        setupLayout()
    }
    
    // MARK: private methods
    
    func fillWith(_ movie: MovieViewModel) {
        if let backdropPath = movie.backdropPath {
            backdrop.sd_setImage(with: backdropPath)
        }
        else {
            backdrop.image = resizeMovie(image: UIImage(named: "backdropPlaceholder")!, to: backdrop.frame.size)
        }
        
        if let posterPath = movie.posterPath {
            poster.sd_setImage(with: posterPath)
        }
        else {
            poster.image = resizeMovie(image: UIImage(named: "backdropPlaceholder")!, to: poster.frame.size)
        }
        
        title.text = movie.title
        
        genres.text = movie.genres
        
        releaseDate.text =  movie.releaseDate
    }
    
    // MARK: private methods
    
    fileprivate func setupView() {
        self.clipsToBounds = true
    }
    
    fileprivate func setupLayout() {
        self.addSubview(backdrop)
        self.addSubview(movieInfo)
        
        backdrop.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: movieInfo.topAnchor, right: self.rightAnchor, padding: .zero, size: CGSize(width: 0, height: self.bounds.width / (16/9)))
        
        movieInfo.anchor(top: backdrop.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        self.addSubview(poster)
        
        movieInfo.addSubview(title)
        movieInfo.addSubview(releaseDate)
        movieInfo.addSubview(genres)
        
        title.anchor(top: movieInfo.topAnchor, left: poster.rightAnchor, bottom: releaseDate.topAnchor, right: movieInfo.rightAnchor, padding: .init(top: 8.0, left: 15.0, bottom: -3.0, right: -15.0))
        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        releaseDate.anchor(top: nil, left: poster.rightAnchor, bottom: genres.topAnchor, right: movieInfo.rightAnchor, padding: .init(top: 3.0, left: 15.0, bottom: -3.0, right: -15.0))
        releaseDate.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        releaseDate.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        genres.anchor(top: nil, left: poster.rightAnchor, bottom:  movieInfo.bottomAnchor, right: movieInfo.rightAnchor, padding: .init(top: 3.0, left: 15.0, bottom: -8, right: -15.0))
        genres.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        genres.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        poster.anchor(top: backdrop.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: -60.0, left: 15.0, bottom: 0, right: 0), size: .init(width: 80.0, height: 120.0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize: CGSize {
        return self.frame.size
    }
}

extension MovieHeaderView: SDWebImageManagerDelegate {
    func imageManager(_ imageManager: SDWebImageManager, transformDownloadedImage image: UIImage?, with imageURL: URL?) -> UIImage? {
        guard let imageURL: URL = imageURL , let image : UIImage = image else { return nil }
        
        let posterSize = poster.frame.size
        let backdropSize = backdrop.frame.size
        
        if imageURL.absoluteString.contains(Domains.backdropURL) {
            return resizeMovie(image: image, to: backdropSize)
        } else if imageURL.absoluteString.contains(Domains.posterURL) {
            return resizeMovie(image: image, to: posterSize)
        }
        
        return image
    }
    
    private func resizeMovie(image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIBezierPath(roundedRect: rect, cornerRadius: 5.0).addClip()
        
        image.draw(in: rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
}
