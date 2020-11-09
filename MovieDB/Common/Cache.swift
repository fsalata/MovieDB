//
//  Cache.swift
//  MovieDB
//
//  Created by Fábio Salata on 06/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit

final class Cache: Cacheable {
    static var shared: Cache = Cache()
    
    private var cache: NSCache<NSString, UIImage>
    
    private init() {
        self.cache = NSCache()
    }
    
    func set(key: String, object: UIImage) {
        cache.setObject(object, forKey: NSString(string: key))
    }
    
    func get(key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
}
