//
//  MoviesServiceTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import XCTest
@testable import MovieDB

class MoviesServiceTests: XCTestCase {
    var moviesService: MoviesService?

    override func setUp() {
        self.moviesService = MoviesService()
    }

    override func tearDown() {
        self.moviesService = nil
    }

    func testFetchMoviesSuccess() {
        let expectation = XCTestExpectation(description: "Movie list downloaded")
        
        self.moviesService?.fetchUpcomingMovies(page: nil, completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data.results, "No movie downloaded")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchMovieByPageSuccess() {
        let expectation = XCTestExpectation(description: "Movie list downloaded")
        
        let currentPage = 3
        
        self.moviesService?.fetchUpcomingMovies(page: currentPage, completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data.results, "No movie downloaded")
                XCTAssert(data.page == currentPage, "Wrong page")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

}
