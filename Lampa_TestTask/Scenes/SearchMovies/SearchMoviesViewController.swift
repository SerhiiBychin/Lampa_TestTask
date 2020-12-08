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
    
    
    private var moviesSearchResult = [MovieItemViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var searchMoviesViewModel: SearchMoviesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        bind()
    }
    
    
    func bind() {
        searchMoviesViewModel.moviesSearchResult.bind { [weak self] (movies) in
            guard let self = self else { return }
            self.moviesSearchResult = movies.map { MovieItemViewModel(movie: $0) }
        }
        
        searchMoviesViewModel.errorMessage.bind { [weak self] message in
            guard let self = self else { return }
            guard let message = message else { return }
            DispatchQueue.main.async {
                self.presentError(with: message)
            }
        }
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


extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !(searchText.count > 2) {
            moviesSearchResult = []
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.searchMoviesViewModel.searchMovies(forQuery: searchText)
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if searchBar.text == "" { return }
        searchMoviesViewModel.searchMovies(forQuery: searchBar.text!)
    }
    
    
    func setupSearchBar() {
        searchBar.delegate = self
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
