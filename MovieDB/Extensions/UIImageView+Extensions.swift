//
//  UIImageView+Extensions.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import UIKit

extension UIImageView {
    
    private struct AssociatedKeys {
        static var sessionDataTask = "sessionDataTask"
    }
    
    private var task: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.sessionDataTask) as? URLSessionDataTask
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self,
                                         &AssociatedKeys.sessionDataTask,
                                         newValue,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    /// Download de imagens
    /// - Parameters:
    ///   - url: Url da imagem
    ///   - placeholder: View de apresentação enquanto a imagem não foi obtida
    ///   - cache: Objeto para manter a image de forma local e temporária
    func load<T: Cacheable>(url: URL,
                                placeholder: UIView?,
                                cache: T?) where T.Key == String, T.Object == UIImage {
        if let imageCache = cache?.get(key: url.absoluteString) {
            self.image = imageCache
        } else {
            task?.cancel()
            task = nil
            
            if let placeholder = placeholder {
                placeholder.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(placeholder)
                placeholder.pinEdgesToSuperview()
            }
            
            task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    placeholder?.removeFromSuperview()
                    guard self.task != nil,
                          let data = data else {
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.image = image
                    cache?.set(key: url.absoluteString,
                              object: image)
                }
            }
            task?.resume()
        }
    }
}
