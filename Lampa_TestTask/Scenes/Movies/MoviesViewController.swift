//
//  MoviesViewController.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 05.12.2020.
//

import UIKit

class MoviesViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableview: UITableView!
    
    
    private var dataSource = [MovieItemViewModel]()
    var moviesViewModel: MoviesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    
    func bind() {
        moviesViewModel.movies.bind { movies in
            self.dataSource = movies.map { MovieItemViewModel(movie: $0) }
        }
        
        moviesViewModel.errorMessage.bind { (message) in
            
        }
    }
}


extension MoviesViewController: StaticFactory {
    enum Factory {
        static var `default`: MoviesViewController {
            guard let moviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else { return MoviesViewController() }
            moviesVC.moviesViewModel = MoviesViewModel(tmdbAPIService: TMDBAPIService.Factory.default)
            return moviesVC
        }
    }
}



