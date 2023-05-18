//
//  UpcomingMoviesServiceProtocol.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

protocol UpcomingMoviesServiceProtocol {
    var api: API { get }

    func fetchUpcoming(page: Int) async throws -> MoviesResult
}
