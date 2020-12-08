//
//  SearchMoviesViewController.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 09.12.2020.
//

import UIKit

class SearchMoviesViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension SearchMoviesViewController: StaticFactory {
    enum Factory {
        static var `default`: SearchMoviesViewController {
            guard let moviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchMoviesViewController") as? SearchMoviesViewController else { return SearchMoviesViewController() }
//            moviesVC.moviesViewModel = MoviesViewModel(tmdbAPIService: TMDBAPIService.Factory.default)
            return moviesVC
        }
    }
}
