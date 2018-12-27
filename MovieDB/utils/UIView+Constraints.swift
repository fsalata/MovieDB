//
//  UIView+Constraints.swift
//  MovieDB
//
//  Created by Fabio Salata on 27/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pinEdgesToSuperview(_ offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: offset).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset).isActive = true
    }
}
