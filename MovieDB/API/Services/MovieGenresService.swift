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
    func fetchMovieGenres(completion: @escaping (GenresModel?, ServiceError?) -> ()) -> URLSessionDataTask? {
        
        return client.load(path: "genre/movie/list", method: RequestMethod.get, params: nil) { (result, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let result = result else { return }
            
            do {
                let genresList = try JSONDecoder().decode(GenresModel.self, from: result)
                
                completion(genresList, nil)
            } catch let error {
                print(error)
            }
        }
    }
}
