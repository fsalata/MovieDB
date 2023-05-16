//
//  GenresServiceProtocol.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

protocol GenresServiceProtocol {
    func fetchGenres() async throws -> ([GenresResult], URLResponse)
}
