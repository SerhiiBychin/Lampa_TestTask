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
    
    
    private var moviesSearchResult = [MovieItemViewModel]()
    private var searchMoviesViewModel: SearchMoviesViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}


extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell", for: indexPath) as! PopularMovieTableViewCell
        cell.configure(with: moviesSearchResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
    }
    
    
    func registerTableViewCell() {
        let moviesCell = UINib(nibName: "PopularMovieTableViewCell", bundle: nil)
        tableView.register(moviesCell, forCellReuseIdentifier: "PopularMovieTableViewCell")
    }
}


extension SearchMoviesViewController: StaticFactory {
    enum Factory {
        static var `default`: SearchMoviesViewController {
            guard let searchMoviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchMoviesViewController") as? SearchMoviesViewController else { return SearchMoviesViewController() }
            searchMoviesVC.searchMoviesViewModel = SearchMoviesViewModel(tmdbAPIService: TMDBAPIService.Factory.default)
            return searchMoviesVC
        }
    }
}
