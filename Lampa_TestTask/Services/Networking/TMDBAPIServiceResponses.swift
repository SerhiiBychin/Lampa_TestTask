//
//  TMDBAPIServiceResponses.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
