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
    
    var moviesViewModel: MoviesViewModel?

    override func setUp() {
        self.moviesViewModel = MoviesViewModel()
    }

    override func tearDown() {
        self.moviesViewModel = nil
    }

    func testFetchMoviesSuccess() {
        let expectation = XCTestExpectation(description: "Movie genres downloaded")
        
        self.moviesViewModel?.fetch {
            XCTAssertNotNil(self.moviesViewModel?.genres, "no genres was downloaded")
            XCTAssertNotNil(self.moviesViewModel?.movies, "no movie was downloaded")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchMoviesWithPageSuccess() {
        self.moviesViewModel?.currentPage = 3
        
        let expectation = XCTestExpectation(description: "Movie genres downloaded")
        
        self.moviesViewModel?.fetch {
            XCTAssertNotNil(self.moviesViewModel?.genres, "no genres was downloaded")
            XCTAssertNotNil(self.moviesViewModel?.movies, "no movie was downloaded")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

}
