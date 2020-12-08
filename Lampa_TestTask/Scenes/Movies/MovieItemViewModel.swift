//
//  MovieItemViewModel.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

struct MovieItemViewModel {
    let title: String
    let overview: String
    let imageURL: String?
    let releaseDate: String
    
    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.imageURL = "https://image.tmdb.org/t/p/w400" + (movie.posterPath ?? "")
        self.releaseDate = movie.releaseDate ?? "Unknown"
    }
}
