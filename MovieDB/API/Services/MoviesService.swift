//
//  MovieService.swift
//  MovieDB
//
//  Created by Fabio Salata on 04/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

final class MoviesService {
    private let client = WebClient()

    @discardableResult
    func fetchUpcomingMovies(page: Int?, completion: @escaping (MoviesModel?, ServiceError?) -> ()) -> URLSessionDataTask? {
        
        var parameters: JSON = [String: Any]()
        
        if let page = page {
            parameters["page"] = page
        }

        return client.load(path: "movie/upcoming", method: .get, params: parameters) { result, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let result = result  else { return }
            
            do {
                let moviesList = try JSONDecoder().decode(MoviesModel.self, from: result)
                
                completion(moviesList, error)
            } catch let error {
                print(error)
            }
        }
    }
}
