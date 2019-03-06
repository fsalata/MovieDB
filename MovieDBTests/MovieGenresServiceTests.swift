//
//  MovieGenresServiceTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieGenresServiceTests: XCTestCase {
    
    var genresService: MovieGenresService?

    override func setUp() {
        self.genresService = MovieGenresService()
    }

    override func tearDown() {
        self.genresService = nil
    }

    func testFetchMovieGenresSuccess() {
        let expectation = XCTestExpectation(description: "Genres downloaded")
        
        self.genresService?.fetchMovieGenres(completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data.genres, "No genres downloaded")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

}
