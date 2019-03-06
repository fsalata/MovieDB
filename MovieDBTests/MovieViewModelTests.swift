//
//  MovieViewModelTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 28/02/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieViewModelTests: XCTestCase {
    
    var movieViewModel: MovieViewModel?
    
    let id = 490132
    let title = "Green Book"
    let posterPath = "/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg"
    let genreIDS = [18, 35, 10402]
    let backdropPath = "/78PjwaykLY2QqhMfWRDvmfbC6EV.jpg"
    let overview = "Tony Lip, a bouncer in 1962, is hired to drive pianist Don Shirley on a tour through the Deep South in the days when African Americans, forced to find alternate accommodations and services due to segregation laws below the Mason-Dixon Line, relied on a guide called The Negro Motorist Green Book."
    let releaseDate = "2018-11-16"

    override func setUp() {
        
        let movie =  Movie(id: id, title: title, posterPath: posterPath, genreIDS: genreIDS, backdropPath: backdropPath, overview: overview, releaseDate: releaseDate)
        
        let genres = [Genre(id: 18, name: "Drama"), Genre(id: 35, name: "Comedy"), Genre(id: 10402, name: "Music")]
        
        self.movieViewModel = MovieViewModel(movie: movie, genres: genres)
    }

    override func tearDown() {
        self.movieViewModel = nil
    }

    func testMovieViewModelPropertiesSuccess() {
        let posterPathExpectation = URL(string: Domains.posterURL + posterPath)
        let backdropPathExpectation = URL(string: Domains.posterURL + backdropPath)
        let genresExpectation = "Drama, Comedy, Music"
        let releaseDateExpectation = "16/11/2018"
        
        
        XCTAssert(self.movieViewModel?.title == title, "Title error")
        XCTAssert(self.movieViewModel?.posterPath == posterPathExpectation, "Poster path error")
        XCTAssert(self.movieViewModel?.backdropPath == backdropPathExpectation, "Backdrop path error")
        XCTAssert(self.movieViewModel?.genres == genresExpectation, "Genres error")
        XCTAssert(self.movieViewModel?.overview == overview, "OverviewError")
        XCTAssert(self.movieViewModel?.releaseDate == releaseDateExpectation, "Release date error")
    }

}
