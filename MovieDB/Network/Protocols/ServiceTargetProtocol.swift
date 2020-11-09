//
//  ServiceTargetProtocol.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

protocol ServiceTargetProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var parameters: JSON? { get }
}
