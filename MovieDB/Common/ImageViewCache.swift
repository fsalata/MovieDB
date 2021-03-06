//
//  ImageViewCache.swift
//  MovieDB
//
//  Created by Fábio Salata on 18/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import UIKit
import Combine

class ImageViewCache: UIImageView {
    var url: URL?
    var dataCancellable: AnyCancellable?
    var cache = Cache.shared
    
    func loadImage(url: URL?, placeholder: UIView?) {
        guard let url = url else {
            self.image = UIImage(named: "backdropPlaceholder")
            return
        }
        
        self.url = url
        
        if let imageCache = cache.get(key: url.absoluteString) {
            self.image = imageCache
        } else {
            dataCancellable?.cancel()
            
            if let placeholder = placeholder {
                placeholder.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(placeholder)
                placeholder.pinEdgesToSuperview()
            }
            
            dataCancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {[weak self] completion in
                    if case .failure(_) = completion {
                        self?.image = UIImage(named: "backdropPlaceholder")
                    }
                }, receiveValue: {[weak self] imageData in
                    guard let image = UIImage(data: imageData) else {
                        self?.image = UIImage(named: "backdropPlaceholder")
                        return
                    }
                    
                    self?.image = image
                    self?.cache.set(key: url.absoluteString, object: image)
                })
        }
    }

}
