//
//  GenresService.swift
//  MovieDB
//
//  Created by Fabio Salata on 14/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation

final class MovieGenresService {
    let client = WebClient()
    
    @discardableResult
    func fetchMovieGenres(completion: @escaping (Result<GenresModel?, ServiceError>) -> ()) -> URLSessionDataTask? {
        
        return client.load(path: "genre/movie/list", method: RequestMethod.get, params: nil) { result in
            
            switch result {
            case .success(let data):
                let genresList = try? JSONDecoder().decode(GenresModel.self, from: data)
                completion(Result.success(genresList))
            case .failure(let error):
                completion(Result.failure(error))
            }
            
           
        }
    }
}
