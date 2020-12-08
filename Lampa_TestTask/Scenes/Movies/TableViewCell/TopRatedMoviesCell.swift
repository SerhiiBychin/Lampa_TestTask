//
//  MovieTableViewCell.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import UIKit

class TopRatedMoviesCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var topRatedMoviesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var collectionViewDataSource = [MovieItemViewModel]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
      super.layoutSubviews()
      
      (topRatedMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?
        .itemSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    
    func setupPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = collectionViewDataSource.count
    }
}


extension TopRatedMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMoviesCollectionViewCell", for: indexPath as IndexPath) as! TopRatedMoviesCollectionViewCell
        cell.configure(with: collectionViewDataSource[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    
    func setupCollectionView() {
        topRatedMoviesCollectionView.dataSource = self
        topRatedMoviesCollectionView.delegate = self
        registerTCollectionViewCell()
    }
    
    
    func setCollectionViewDataSource(_ dataSource: [MovieItemViewModel]) {
        self.collectionViewDataSource = dataSource
        setupPageControl()
    }
    
    
    func registerTCollectionViewCell() {
        let topRatedMoviesCollectionViewCell = UINib(nibName: "TopRatedMoviesCollectionViewCell", bundle: nil)
        topRatedMoviesCollectionView.register(topRatedMoviesCollectionViewCell, forCellWithReuseIdentifier: "TopRatedMoviesCollectionViewCell")
    }
}
