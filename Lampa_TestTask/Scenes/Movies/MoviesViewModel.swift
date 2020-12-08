//
//  MoviesViewModel.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

class MoviesViewModel {
    private let tmdbAPIService: TMDBAPIProvider
        
    var popularMovies: Observable<[Movie]> = Observable([])
    var topRatedMovies: Observable<[Movie]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(tmdbAPIService: TMDBAPIProvider) {
        self.tmdbAPIService = tmdbAPIService
        fetchTopRatedMovies()
        fetchPopularMovies()
    }
    
    
    private func fetchPopularMovies() {
        tmdbAPIService.fetchPopularMovies { [weak self] (result) in
            switch result {
            
            case .success(let movies):
                self?.popularMovies.value = movies
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    
    private func fetchTopRatedMovies() {
        tmdbAPIService.fetchTopRatedMovies { [weak self] (result) in
            switch result {
            
            case .success(let movies):
                self?.topRatedMovies.value = movies
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
}


