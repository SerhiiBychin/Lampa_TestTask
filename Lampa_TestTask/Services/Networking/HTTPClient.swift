//
//  HTTPClient.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

protocol HTTPClientProvider {
    func get(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func post(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class HTTPClient: HTTPClientProvider {    
    private func performDataTaskWith(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                completion(.success(data))
            } else {
                completion(.failure(HTTPClientError.responseStatusError(message: "Server error")))
            }
        }.resume()
    }
    
    
    func get(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(HTTPClientError.emptyURL(message: "Empty URL"))) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        performDataTaskWith(request, completion: completion)
    }
    
    
    func post(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(HTTPClientError.emptyURL(message: "Empty URL"))) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        performDataTaskWith(request, completion: completion)
    }
}
