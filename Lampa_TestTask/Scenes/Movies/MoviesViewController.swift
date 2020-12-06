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
    @IBOutlet weak var tableView: UITableView!
    
    
    private var dataSource = [MovieItemViewModel]()
    private var moviesViewModel: MoviesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        registerTableViewCell()
        bind()
    }
    
    
    func bind() {
        moviesViewModel.movies.bind { movies in
            self.dataSource = movies.map { MovieItemViewModel(movie: $0) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        moviesViewModel.errorMessage.bind { message in
            guard let message = message else { return }
            self.presentError(with: message)
        }
    }
}


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func registerTableViewCell() {
        let userCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(userCell, forCellReuseIdentifier: "MovieTableViewCell")
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



