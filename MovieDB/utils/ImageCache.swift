//
//  ImageCache.swift
//  MovieDB
//
//  Created by Fabio Salata on 15/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

struct ImageCache {
    static let sharedInstance = ImageCache()
    
    let cache = NSCache<NSString, UIImage>()
}
