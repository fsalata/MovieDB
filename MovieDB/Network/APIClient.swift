//
//  APIClient.swift
//  UIKitProjectSeed
//
//  Created by Fábio Salata on 05/11/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

class APIClient {
    private var session: URLSessionProtocol
    private var api: APIProtocol
    private var sessionDataTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared,
         api: APIProtocol = API()) {
        self.session = session
        self.api = api
    }
    
    func request<T: Decodable>(target: ServiceTargetProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            var urlRequest = try URLRequest(baseURL: api.baseURL, target: target)
            urlRequest.allHTTPHeaderFields = target.header
            
            sessionDataTask = self.session.dataTask(with: urlRequest) { (data, response, error) in
                self.debugResponse(request: urlRequest, data: data)
                
                if let error = error as? URLError {
                    completion(.failure(NetworkError(error)))
                }
                else if let response = response as? HTTPURLResponse,
                        !(200..<300 ~= response.statusCode) {
                    completion(.failure(NetworkError(response)))
                } else {
                    guard let data = data else {
                        completion(.failure(.service(.noData)))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: data)
                        
                        completion(.success(decoded))
                    } catch(let error) {
                        if let error = error as? DecodingError {
                            completion(.failure(NetworkError(error)))
                        }
                    }
                }
            }
            
            sessionDataTask?.resume()
        } catch (let error) {
            guard let error = error as? NetworkError else {
                completion(.failure(.unknown))
                return
            }
            completion(.failure(error))
        }
    }
    
    func cancelRequest() {
        guard let sessionDataTask = self.sessionDataTask,
              sessionDataTask.state == URLSessionTask.State.running else {
            return
        }
        sessionDataTask.cancel()
    }
}
    
extension APIClient {
    private func debugResponse(request: URLRequest, data: Data?) {
        print("==== REQUEST ====")
        print("\nURL: \(request.url?.absoluteString ?? "")")
        
        if let requestHeader = request.allHTTPHeaderFields {
            if let data = try? JSONSerialization.data(withJSONObject: requestHeader, options: .prettyPrinted) {
                print("\nHEADER: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        
        print("\nMETHOD: \(request.httpMethod ?? "")")
        
        print("\n==== RESPONSE ====")
        if let data = data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                }
            }
        }
        print("\n================\n")
    }
}


