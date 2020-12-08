//
//  MoviesViewController.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 05.12.2020.
//

import UIKit

class MoviesViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView!
    
    private var topRatedMovies = [MovieItemViewModel]()
    private var popularMovies = [MovieItemViewModel]()
    private var moviesViewModel: MoviesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchVC = SearchMoviesViewController.Factory.default
        searchVC.navigationItem.title = "Search for movies"
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    func bind() {
        moviesViewModel.topRatedMovies.bind { [weak self] movies in
            guard let self = self else { return }
            self.topRatedMovies = movies.map { MovieItemViewModel(movie: $0) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        moviesViewModel.popularMovies.bind { [weak self] movies in
            guard let self = self else { return }
            self.popularMovies = movies.map { MovieItemViewModel(movie: $0) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        moviesViewModel.errorMessage.bind { [weak self] message in
            guard let self = self else { return }
            guard let message = message else { return }
            self.presentError(with: message)
        }
    }
}


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedMoviesCell", for: indexPath) as! TopRatedMoviesCell
            cell.setCollectionViewDataSource(topRatedMovies)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell", for: indexPath) as! PopularMovieTableViewCell
            cell.configure(with: popularMovies[indexPath.row])
            return cell
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        let topRatedMoviesCell = UINib(nibName: "TopRatedMoviesCell", bundle: nil)
        let popularMoviesCell = UINib(nibName: "PopularMovieTableViewCell", bundle: nil)
        tableView.register(topRatedMoviesCell, forCellReuseIdentifier: "TopRatedMoviesCell")
        tableView.register(popularMoviesCell, forCellReuseIdentifier: "PopularMovieTableViewCell")
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



