//
//  Publisher+Extensions.swift
//  MovieDB
//
//  Created by Fábio Salata on 26/11/20.
//  Copyright © 2020 Fabio Salata. All rights reserved.
//

import Foundation
import Combine

typealias URLResponseType = (data:  Data, response: URLResponse)

extension Publisher where Output == URLResponseType {
    func extractData() -> Publishers.TryMap<Self, Data> {
        tryMap { data, response in
            if let response = response as? HTTPURLResponse,
               !(200..<300).contains(response.statusCode) {
                throw APIError(response)
            }
            
            return data
        }
    }
    
    func debugResponse(request: URLRequest) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: { output in
            #if DEBUG
            Swift.print("============================ REQUEST ============================")
            Swift.print("\nURL: \(request.url?.absoluteString ?? "")")
            
            if let requestHeader = request.allHTTPHeaderFields {
                if let data = try? JSONSerialization.data(withJSONObject: requestHeader, options: .prettyPrinted) {
                    Swift.print("\nHEADER: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }
            
            Swift.print("\nMETHOD: \(request.httpMethod ?? "")")
            
            Swift.print("\n============================ RESPONSE ============================")
            if let jsonObject = try? JSONSerialization.jsonObject(with: output.data) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    Swift.print(String(data: jsonData, encoding: .utf8) ?? "")
                }
            }
            
            Swift.print("\n==================================================================\n")
            #endif
        })
    }
}

extension Publisher where Output == Data {
    func decode<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = .init()) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}
