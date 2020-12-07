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
    
    
    private var popularMovies = [MovieItemViewModel]()
    private var topRatedMovies = [MovieItemViewModel]()
    private var moviePages = [MoviePage]()
    private var moviesViewModel: MoviesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
        setScrollViewDelegates()
        registerTableViewCell()
        bind()
    }
    
    
    func bind() {
        moviesViewModel.popularMovies.bind { movies in
            self.popularMovies = movies.map { MovieItemViewModel(movie: $0) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        moviesViewModel.topRatedMovies.bind { movies in
            self.topRatedMovies = movies.map { MovieItemViewModel(movie: $0) }
            DispatchQueue.main.async {
                self.createMoviePages(with: self.topRatedMovies)
                self.setupMoviePageScrollView()
                self.setupPageControl()
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
        popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: popularMovies[indexPath.row])
        return cell
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func registerTableViewCell() {
        let userCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(userCell, forCellReuseIdentifier: "MovieTableViewCell")
    }
}


extension MoviesViewController: UIScrollViewDelegate {
    func createMoviePages(with topRatedMovies: [MovieItemViewModel]) {
        topRatedMovies.forEach { (item) in
            let moviePage: MoviePage = Bundle.main.loadNibNamed("MoviePage", owner: self, options: nil)?.first as! MoviePage
            moviePage.configure(with: item)
            moviePages.append(moviePage)
        }
    }
    
    
    func setupMoviePageScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - tableView.frame.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(moviePages.count), height: view.frame.height - tableView.frame.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height)
        
        
        for i in 0..<moviePages.count {
            moviePages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height - tableView.frame.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height)
            scrollView.addSubview(moviePages[i])
        }
    }
    
    
    func setupPageControl() {
        pageControl.numberOfPages = moviePages.count
        pageControl.currentPage = 0
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    
    func setScrollViewDelegates() {
        scrollView.delegate = self
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



