//
//  API.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

struct API: APIProtocol {
    let baseURL = "https://api.themoviedb.org/3/"

    let backdropURL = "https://image.tmdb.org/t/p/w1280"
    let posterURL = "https://image.tmdb.org/t/p/w500"
}
