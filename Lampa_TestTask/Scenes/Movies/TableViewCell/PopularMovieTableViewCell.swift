//
//  PopularMovieTableViewCell.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 08.12.2020.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: MovieItemViewModel) {
        movieTitleLabel.text = item.title
        movieOverviewLabel.text = item.overview
        releaseDateLabel.text = item.releaseDate
        if let imageURL = item.imageURL {
            movieImageView.loadImage(from: URL(string: imageURL)!)
        }
    }
}
