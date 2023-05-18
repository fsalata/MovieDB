//
//  HomeScreen.swift
//  MovieDB
//
//  Created by Fabio Salata on 16/05/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeViewModel

    init(repository: MoviesRepository) {
        self.viewModel = HomeViewModel(repository: repository)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if !viewModel.trendingMovies.isEmpty || !viewModel.upcomingMovies.isEmpty {
                        if !viewModel.trendingMovies.isEmpty {
                            MovieCardList(title: "Trending", movies: viewModel.trendingMovies)
                        }

                        if !viewModel.upcomingMovies.isEmpty {
                            MovieCardList(title: "Upcoming", movies: viewModel.upcomingMovies)
                        }
                    } else {
                        Spacer()
                        
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 16)
                .task {
                    viewModel.fetchHomeMovies()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("tmdb")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color("AccentColor"), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .environmentObject(viewModel)
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static let api = API()
    static let client = APIClient(api: Self.api, decoder: JSONDecoder())
    static let repository = MoviesRepository(client: Self.client)

    static var previews: some View {
        HomeScreen(repository: Self.repository)
    }
}
