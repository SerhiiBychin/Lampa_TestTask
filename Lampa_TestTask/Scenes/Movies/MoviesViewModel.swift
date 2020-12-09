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
    
    private let group = DispatchGroup()
    
    
    init(tmdbAPIService: TMDBAPIProvider) {
        self.tmdbAPIService = tmdbAPIService
        fetchMoviesConcurrently()
    }
    
    
    private func fetchPopularMovies() {
        group.enter()
        tmdbAPIService.fetchPopularMovies { [weak self] (result) in
            switch result {
            
            case .success(let movies):
                self?.popularMovies.value = movies
                self?.group.leave()
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
                self?.group.leave()
            }
        }
    }
    
    
    private func fetchTopRatedMovies() {
        group.enter()
        tmdbAPIService.fetchTopRatedMovies { [weak self] (result) in
            switch result {
            
            case .success(let movies):
                self?.topRatedMovies.value = movies
                self?.group.leave()
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
                self?.group.leave()
            }
        }
    }
    
    
    private func fetchMoviesConcurrently() {
        fetchTopRatedMovies()
        fetchPopularMovies()
        
        group.notify(queue: .main) {
            print("DONE!!!")
        }
    }
}


