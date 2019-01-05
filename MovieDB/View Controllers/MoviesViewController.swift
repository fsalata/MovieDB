//
//  MoviesTableViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, DataLoading {
    var tableView: UITableView!
    
    var movies = [MovieViewModel]()
    var genres = [Genre]()
    
    var currentPage = 1
    var totalPages: Int?
    
    let loadingMore = UIActivityIndicatorView()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [MovieViewModel]()
    
    var isLoadingMore = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoadingMore {
                    self.loadingMore.startAnimating()
                }
                else {
                    self.loadingMore.stopAnimating()
                }
            }
        }
    }
    
    // MARK - Data loading protocol
    
    var loadingView: LoadingView = LoadingView()
    var errorView: ErrorView = ErrorView()
    
    var state: ViewState<[MovieViewModel]> = .loading {
        didSet {
            update()
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = UIView()
        
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchMoviesGenres()
    }
    
    // MARK: View and Layout
    
    fileprivate func setupLayout() {
        tableView = UITableView(frame: self.view.frame)
        
        self.view.addSubview(tableView)
        
        tableView.pinEdgesToSuperview()
        
        self.view.addSubviews(loadingView, errorView)
        
        loadingView.pinEdgesToSuperview()
        errorView.pinEdgesToSuperview()
    }
    
    private func setupView() {
        title = "Upcoming movies"
        
        let backgroundColor = UIColor(r: 2, g: 34, b: 67)
        
        loadingView.backgroundColor = backgroundColor
        errorView.backgroundColor = backgroundColor
        
        errorView.button.setTitle("Try again?", for: .normal)
        errorView.button.addTarget(self, action: #selector(fetchMoviesGenres), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        tableView.backgroundColor = backgroundColor
        tableView.backgroundView?.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 280.0
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        loadingMore.style = UIActivityIndicatorView.Style.white
        loadingMore.frame = .init(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        tableView.tableFooterView = self.loadingMore
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Private methods
    
    @objc private func fetchMoviesGenres () {
        self.state = .loading
        
        MovieGenresService().fetchMovieGenres { (genresList, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.state = .error(message: error.localizedDescription)
                }
            } else if let genres = genresList?.genres {
                self.genres = genres
                self.fetchMovies(page: self.currentPage)
            }
        }
    }
    
    private func fetchMovies(page: Int) {
        MoviesService().fetchUpcomingMovies(page: page) { moviesList, error in
            self.isLoadingMore = false
            
            DispatchQueue.main.async {
                if let error = error {
                    self.state = .error(message: error.localizedDescription)
                } else if let moviesList = moviesList,
                    let results = moviesList.results {
                    
                    self.totalPages = moviesList.totalPages
                    
                    self.movies += results.map {
                        return MovieViewModel(movie: $0, genres: self.genres)
                    }
                    
                    self.state = .loaded(data: self.movies)
                }
            }
        }
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        var movie: MovieViewModel
        
        if isFiltering() {
            movie = filteredMovies[indexPath.row]
        }
        else {
            movie = movies[indexPath.row]
        }
        
        cell.movie = movie
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movies[indexPath.row]
        
        guard let navigationController = self.navigationController else { return }
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalPages = self.totalPages, !isLoadingMore else { return }
        
        if indexPath.row == movies.count - 5 && currentPage <= totalPages {
            isLoadingMore = true
            currentPage = currentPage + 1
            
            fetchMovies(page: currentPage)
            
            if currentPage == totalPages {
                tableView.tableFooterView = UIView(frame: CGRect.zero)
            }
        }
    }
}

//  MARK: UISearchResultsUpdating
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredMovies = movies.filter({( movie: MovieViewModel) -> Bool in
            return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        
        tableView.reloadData()
    }
}
