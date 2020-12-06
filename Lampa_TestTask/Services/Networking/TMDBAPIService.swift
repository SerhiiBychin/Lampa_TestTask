//
//  TMDBAPIService.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

protocol TMDBAPIMoviesProvider {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}


protocol TMDBAPIProvider: TMDBAPIMoviesProvider {}


final class TMDBAPIService: TMDBAPIProvider {
    private struct Constants {
        static let apiKey = "f910e2224b142497cc05444043cc8aa4"
    }
    
    private let httpClient: HTTPClientProvider
    
    init(httpClient: HTTPClientProvider = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        httpClient.get(url: "https://api.themoviedb.org/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US") { (result) in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(MoviesResponse.self, from: data) else { return }
                completion(.success(response.results))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


extension TMDBAPIService: StaticFactory {
    enum Factory {
        static let `default`: TMDBAPIProvider = TMDBAPIService()
    }
}
