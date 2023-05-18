//
//  APIClient.swift
//  Counters
//

import Foundation

class APIClient {
    private var session: URLSessionProtocol
    private(set) var api: APIProtocol
    private var decoder: JSONDecoder

    init(session: URLSessionProtocol = URLSession.shared,
         api: APIProtocol,
         decoder: JSONDecoder) {
        self.session = session
        self.api = api
        self.decoder = decoder
    }

    /// Async Request
    /// - Returns: (T: Decodable, URLResponse?)
    func request<T: Decodable>(target: ServiceTargetProtocol) async throws -> T {
        guard var urlRequest = try? URLRequest(baseURL: api.baseURL, target: target) else {
            throw APIError.network(.badURL)
        }

        urlRequest.allHTTPHeaderFields = target.header

        let (data, response) = try await session.data(for: urlRequest, delegate: nil)

        if let response = response as? HTTPURLResponse,
           response.validationStatus != .success {
            let error = APIError(response)

            debugResponse(request: urlRequest, data: data, response: response, error: error)
            
            throw error
        }
        
        debugResponse(request: urlRequest, data: data, response: response, error: nil)
        
        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }
}

extension APIClient {
    // Print API request/response data
    func debugResponse(request: URLRequest, data: Data?, response: URLResponse?, error: Error?) {
        #if DEBUG
        Swift.print("============================ REQUEST ============================")
        Swift.print("\nURL: \(request.url?.absoluteString ?? "")")

        Swift.print("\nMETHOD: \(request.httpMethod ?? "")")

        if let requestHeader = request.allHTTPHeaderFields {
            if let data = try? JSONSerialization.data(withJSONObject: requestHeader, options: .prettyPrinted) {
                Swift.print("\nHEADER: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        if let requestBody = request.httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(with: requestBody) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    Swift.print("\nBODY: \(String(data: jsonData, encoding: .utf8) ?? "")")
                }
            }
        }

        Swift.print("\n============================ RESPONSE ============================")
        if let data = data,
           let jsonObject = try? JSONSerialization.jsonObject(with: data) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                Swift.print(String(data: jsonData, encoding: .utf8) ?? "")
            }
        }

        if let urlError = error as? URLError {
            print("\n❌ ======= ERROR =======")
            print("❌ CODE: \(urlError.errorCode)")
            print("❌ DESCRIPTION: \(urlError.localizedDescription)\n")
        }

        Swift.print("\n==================================================================\n")
        #endif
    }
}
