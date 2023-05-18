//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    typealias Repository = TrendingMoviesServiceProtocol & UpcomingMoviesServiceProtocol

    private(set) var repository: Repository

    @Published private(set) var trendingMovies: [Movie] = []
    private var trendingPage = 1
    private var trendingTotalPages = 0

    @Published private(set) var upcomingMovies: [Movie] = []
    private var upcomingPage = 1
    private var upcomingTotalPages = 0

    @Published private(set) var nowPlayingMovies: [Movie] = []
    private var nowPlayingPage = 1
    private var nowPlayingTotalPages = 0

    @Published private (set) var error: APIError? = nil

    init(repository: Repository) {
        self.repository = repository
    }
}

// MARK: - Public Methods
extension HomeViewModel {
    func getPosterURL(for path: String?) -> URL? {
        return URL(baseUrl: repository.api.posterURL, path: path ?? "", parameters: nil, method: .GET)
    }
}

// MARK: - Networking
extension HomeViewModel {
    func fetchHomeMovies() {
        Task {
            async let fetchTrending = repository.fetchTrending(page: trendingPage)
            async let fetchUpcoming = repository.fetchUpcoming(page: upcomingPage)

            do {
                let (trendingResult, upcomingResult) = try await (fetchTrending, fetchUpcoming)

                trendingPage = trendingResult.page
                trendingTotalPages = trendingResult.totalPages ?? 0

                upcomingPage = upcomingResult.page
                upcomingTotalPages = upcomingResult.totalPages ?? 0

                await MainActor.run {
                    trendingMovies = trendingResult.results ?? []
                    upcomingMovies = upcomingResult.results ?? []
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
