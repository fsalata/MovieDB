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
        self.layer.masksToBounds = false
    }
}
