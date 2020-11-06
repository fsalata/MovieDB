//
//  API.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

struct API: APIProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
}
