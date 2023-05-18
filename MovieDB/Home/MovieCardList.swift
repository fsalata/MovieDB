//
//  MovieCardList.swift
//  MovieDB
//
//  Created by Fabio Salata on 17/05/23.
//

import SwiftUI

struct MovieCardList: View {
    @EnvironmentObject var viewModel: HomeViewModel

    let title: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movies, id: \.id) { movie in
                        MovieCard(movie: movie)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct MovieCard: View {
    @EnvironmentObject var viewModel: HomeViewModel

    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: viewModel.getPosterURL(for: movie.posterPath)) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 255)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 255)
            }

            Text("\(movie.title)")
                .font(.callout)

            if let date = movie.releaseDate {
                Text(date, style: .date)
                    .font(.caption)
            }

            Spacer()
        }
        .frame(width: 150, height: 314)
    }
}

//struct MovieCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieCard()
//    }
//}
