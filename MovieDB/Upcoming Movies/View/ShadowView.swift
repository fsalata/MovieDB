//
//  ShadowView.swift
//  MovieDB
//
//  Created by Fabio Salata on 28/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let path = UIBezierPath(rect: rect).cgPath
        self.layer.shadowPath = path
        self.layer.masksToBounds = false
    }
}
