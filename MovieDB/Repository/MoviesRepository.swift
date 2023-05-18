//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

final class MoviesRepository {
    private let client: APIClient

    let api: API

    init(api: API = API(), client: APIClient) {
        self.api = api
        self.client = client
    }
}

// MARK: - API Calls

// Genres
extension MoviesRepository: GenresServiceProtocol {
    func fetchGenres() async throws -> GenresResult {
        try await client.request(target: GenresTarget.genres)
    }
}

// Trending
extension MoviesRepository: TrendingMoviesServiceProtocol {
    func fetchTrending(page: Int) async throws -> MoviesResult {
        try await client.request(target: TrendingMoviesService.trending(page: page))
    }
}

// Upcoming
extension MoviesRepository: UpcomingMoviesServiceProtocol {
    func fetchUpcoming(page: Int) async throws -> MoviesResult {
        try await client.request(target: UpcomingMoviesTarget.upcoming(page: page))
    }
}
