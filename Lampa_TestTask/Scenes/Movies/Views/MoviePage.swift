//
//  MoviePage.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import UIKit

class MoviePage: UIView {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    
    func configure(with item: MovieItemViewModel) {
        movieTitleLabel.text = item.title
        if let imageURL = item.imageURL {
            movieImageView.loadImage(from: URL(string: imageURL)!)
        }
    }
}
