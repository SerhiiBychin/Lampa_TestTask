//
//  MoviesViewModel.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

class MoviesViewModel {
    private let tmdbAPIService: TMDBAPIProvider
        
    var movies: Observable<[Movie]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(tmdbAPIService: TMDBAPIProvider) {
        self.tmdbAPIService = tmdbAPIService
        fetchPopularMovies()
    }
    
    
    private func fetchPopularMovies() {
        tmdbAPIService.fetchPopularMovies { (result) in
            switch result {
            
            case .success(let movies):
                self.movies.value = movies
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}


