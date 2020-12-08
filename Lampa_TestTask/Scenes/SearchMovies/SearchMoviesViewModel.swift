//
//  SearchMoviesViewModel.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 09.12.2020.
//

import Foundation

class SearchMoviesViewModel {
    private let tmdbAPIService: TMDBAPIProvider
        
    var moviesSearchResult: Observable<[Movie]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(tmdbAPIService: TMDBAPIProvider) {
        self.tmdbAPIService = tmdbAPIService
    }
    
    
    func searchMovies(forQuery query: String) {
        tmdbAPIService.searchMovies(forQuery: query) { [weak self] (result) in
            switch result {
            
            case .success(let movies):
                self?.moviesSearchResult.value = movies
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
}
