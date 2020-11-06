//
//  Cacheable.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

protocol Cacheable {
    associatedtype Key
    associatedtype Object
    
    func set(key: Key, object: Object)
    func get(key: Key) -> Object?
}
