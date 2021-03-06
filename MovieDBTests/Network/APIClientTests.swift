//
//  APIClientTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import XCTest
import Combine
@testable import MovieDB

class APIClientTests: XCTestCase {
    var subscribers = Set<AnyCancellable>()
    
    var sut: APIClient!
    var session: URLSessionSpy!
    
    override func setUp() {
        super.setUp()
        
        session = URLSessionSpy()
        sut = APIClient(session: session, api: MockAPI())
    }
    
    override func tearDown() {
        subscribers = []
        sut = nil
        session = nil
    }
    

    func test_APIClientSuccess() {
        session.data = mockMovies()
        session.response = HTTPURLResponse(url: URL(string: MockAPI().baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let publisher: AnyPublisher<MoviesModel, APIError> = sut.request(target: UpcomingMoviesTarget.movies(page: 0))
        
        var result: MoviesModel?
        
        publisher
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { movies in
                result = movies
            }
            .store(in: &subscribers)

        let request = session.dataTaskArgsRequest.first
        
        XCTAssertEqual(request?.httpMethod, RequestMethod.GET.rawValue)
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.results?.count == 2)
    }
    
    func test_APIClientNetworkFailure() {
        session.urlError = URLError(.badURL)
        
        let publisher: AnyPublisher<MoviesModel, APIError> = sut.request(target: UpcomingMoviesTarget.movies(page: 0))
        
        var result: APIError?
        
        publisher
            .sink { completion in
                switch completion {
                case .failure(let error):
                    result = error
                default:
                    break
                }
            } receiveValue: { movies in
                XCTFail()
            }
            .store(in: &subscribers)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, APIError.network(.badURL))
    }
    
    func test_APIClientServiceFailure() {
        session.response = HTTPURLResponse(url: URL(string: MockAPI().baseURL)!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        let publisher: AnyPublisher<MoviesModel, APIError> = sut.request(target: UpcomingMoviesTarget.movies(page: 0))
        
        var result: APIError?
        
        publisher
            .sink { completion in
                switch completion {
                case .failure(let error):
                    result = error
                default:
                    break
                }
            } receiveValue: { movies in
                XCTFail()
            }
            .store(in: &subscribers)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, APIError.service(.internalServerError))
    }
}

struct MockAPI: APIProtocol {
    let baseURL = "https://imdb.com/"
}
