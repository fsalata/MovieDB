//
//  MovieHeaderView.swift
//  MovieDB
//
//  Created by Fabio Salata on 24/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

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
        return label
    }()
    
    lazy var releaseDate: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        label.textColor = .white
        return label
    }()
    
    lazy var genres: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        setupLayout()
    }
    
    // MARK: private methods
    
    fileprivate func setupView() {
        self.addSubview(backdrop)
        self.addSubview(movieInfo)
        self.addSubview(poster)
        
        movieInfo.addSubview(title)
        movieInfo.addSubview(releaseDate)
        movieInfo.addSubview(genres)
        
        self.clipsToBounds = true
    }
    
    fileprivate func setupLayout() {
        backdrop.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: movieInfo.topAnchor, right: self.rightAnchor, padding: .zero, size: CGSize(width: self.bounds.width, height: self.bounds.width / (16/9)))
        
        movieInfo.anchor(top: backdrop.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        title.anchor(top: movieInfo.topAnchor, left: poster.rightAnchor, bottom: releaseDate.topAnchor, right: movieInfo.rightAnchor, padding: .init(top: 8.0, left: 15.0, bottom: -3.0, right: -15.0))
        
        releaseDate.anchor(top: nil, left: poster.rightAnchor, bottom: genres.topAnchor, right: movieInfo.rightAnchor, padding: .init(top: 3.0, left: 15.0, bottom: -3.0, right: -15.0))
        
        genres.anchor(top: nil, left: poster.rightAnchor, bottom:  movieInfo.bottomAnchor, right: movieInfo.rightAnchor, padding: .init(top: 3.0, left: 15.0, bottom: -8, right: -15.0))
        
        poster.anchor(top: backdrop.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: -60.0, left: 15.0, bottom: 0, right: 0), size: .init(width: 80.0, height: 120.0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
    }
}
