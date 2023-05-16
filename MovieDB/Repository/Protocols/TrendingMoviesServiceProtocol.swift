//
//  TrendingMoviesServiceProtocol.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

protocol TrendingMoviesServiceProtocol {
    func fetchTrending(page: Int) async throws -> ([Movie], URLResponse)
}
