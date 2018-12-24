//
//  MovieHeaderView.swift
//  MovieDB
//
//  Created by Fabio Salata on 24/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

@IBDesignable
final class MovieHeaderView: UIView {
    @IBInspectable
    var borderRadius: CGFloat = 10.0
    
    lazy var backdrop: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "backdropPlaceholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var poster: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "backdropPlaceholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieInfo: UIView! = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDate: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genres: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    // MARK: private methods
    
    fileprivate func setupView() {
        self.addSubview(backdrop)
        self.addSubview(movieInfo)
        self.addSubview(poster)
        
        movieInfo.addSubview(title)
        movieInfo.addSubview(releaseDate)
        movieInfo.addSubview(genres)
        
        self.layer.cornerRadius = borderRadius
        self.clipsToBounds = true
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        backdrop.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backdrop.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        backdrop.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backdrop.bottomAnchor.constraint(equalTo: movieInfo.topAnchor, constant: 0).isActive = true
        backdrop.heightAnchor.constraint(equalToConstant: self.bounds.width / (16/9)).isActive = true
        
        movieInfo.topAnchor.constraint(equalTo: backdrop.bottomAnchor).isActive = true
        movieInfo.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        movieInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        movieInfo.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: movieInfo.topAnchor, constant: 8.0).isActive = true
        title.rightAnchor.constraint(equalTo: movieInfo.rightAnchor, constant: -15.0).isActive = true
        title.bottomAnchor.constraint(equalTo: releaseDate.topAnchor, constant: -3.0).isActive = true
        title.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 15.0).isActive = true
        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        releaseDate.rightAnchor.constraint(equalTo: movieInfo.rightAnchor, constant: -15.0).isActive = true
        releaseDate.bottomAnchor.constraint(equalTo: genres.topAnchor, constant: -3.0).isActive = true
        releaseDate.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 15.0).isActive = true
        releaseDate.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        releaseDate.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        genres.rightAnchor.constraint(equalTo: movieInfo.rightAnchor, constant: -15.0).isActive = true
        genres.bottomAnchor.constraint(equalTo: movieInfo.bottomAnchor, constant: -8.0).isActive = true
        genres.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 15.0).isActive = true
        genres.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        genres.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        poster.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        poster.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: -60.0).isActive = true
        poster.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize: CGSize {
        return self.frame.size
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
