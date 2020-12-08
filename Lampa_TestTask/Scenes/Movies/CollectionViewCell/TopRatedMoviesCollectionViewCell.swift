//
//  TopRatedMoviesCollectionViewCell.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 08.12.2020.
//

import UIKit

class TopRatedMoviesCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var movieImageView: UIImageView!    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(with item: MovieItemViewModel) {
        movieTitleLabel.text = item.title
        releaseDateLabel.text = item.releaseDate
        if let imageURL = item.imageURL {
            movieImageView.loadImage(from: URL(string: imageURL)!)
        }
    }
}
