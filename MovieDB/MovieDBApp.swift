//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import SwiftUI

@main
struct MovieDBApp: App {
    let repository: MoviesRepository

    init() {
        let api = API()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let client = APIClient(api: api, decoder: decoder)
        let repository = MoviesRepository(client: client)

        self.repository = repository
    }

    var body: some Scene {
        WindowGroup {
            HomeScreen(repository: repository)
        }
    }
}
