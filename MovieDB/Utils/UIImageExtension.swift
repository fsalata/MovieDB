//
//  UIImageExtension.swift
//  MovieDB
//
//  Created by Fabio Salata on 13/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
