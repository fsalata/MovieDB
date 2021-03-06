//
//  MoviesViewModelTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import XCTest
@testable import MovieDB

class MoviesViewModelTests: XCTestCase {
    
    var moviesViewModel: UpcomingMoviesViewModel?

    override func setUp() {
        self.moviesViewModel = UpcomingMoviesViewModel()
    }

    override func tearDown() {
        self.moviesViewModel = nil
    }
}
