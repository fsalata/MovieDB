//
//  UpcomingMoviesServiceProtocol.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

protocol UpcomingMoviesServiceProtocol {
    func fetchUpcoming(page: Int) async throws -> ([Movie], URLResponse)
}
