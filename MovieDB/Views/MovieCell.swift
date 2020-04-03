//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MovieCell: UITableViewCell {
    var movieHeaderView: MovieHeaderView!
    
    var movie: MovieViewModel! {
        didSet {
            movieHeaderView.fillWith(movie)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        setupLayout()
    }
    
    private func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(r: 2, g: 34, b: 67)
    }
    
    private func setupLayout() {
        let shadowView = ShadowView(frame: contentView.frame)
        contentView.addSubview(shadowView)
        
        shadowView.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          padding: .init(top: 20.0, left: 10.0, bottom: 0.0, right: -10.0))
        
        movieHeaderView = MovieHeaderView(frame: shadowView.frame)
        shadowView.addSubview(movieHeaderView)
        
        movieHeaderView.pinEdgesToSuperview()
        
        movieHeaderView.layer.cornerRadius = 10.0
        movieHeaderView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        movieHeaderView.backdrop.image =  nil
        movieHeaderView.poster.image =  nil
        
        movieHeaderView.backdrop.sd_cancelCurrentImageLoad()
        movieHeaderView.poster.sd_cancelCurrentImageLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
