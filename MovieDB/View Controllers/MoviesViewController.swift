//
//  MoviesTableViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    var tableView: UITableView!
    
    var movies = [MovieViewModel]()
    var genres = [Genre]()
    
    var currentPage = 1
    var totalPages: Int?
    
    let loadingMore = UIActivityIndicatorView()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [MovieViewModel]()
    
    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.loadingMore.startAnimating()
                }
                else {
                    self.loadingMore.stopAnimating()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupLayout()
        
        fetchMoviesGenres()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        title = "Upcoming movies"
        
        tableView = UITableView(frame: self.view.frame)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        let backgroundColor = UIColor(r: 42, g: 42, b: 42)
        tableView.backgroundColor = backgroundColor
        tableView.backgroundView?.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 280.0
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        loadingMore.style = UIActivityIndicatorView.Style.white
        loadingMore.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        tableView.tableFooterView = self.loadingMore
        
        self.view.addSubview(tableView)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func setupLayout() {
        tableView.pinEdgesToSuperview()
    }
    
    private func fetchMoviesGenres () {
        MovieGenresService().fetchMovieGenres { (genresList, error) in
            if let error = error {
                self.showErrorAlert(error: error)
            } else if let genres = genresList?.genres {
                self.genres = genres
                self.fetchMovies(page: self.currentPage)
            }
        }
    }
    
    private func fetchMovies(page: Int) {
        MoviesService().fetchUpcomingMovies(page: page) { moviesList, error in
            self.isLoading = false
            
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(error: error)
                } else if let moviesList = moviesList,
                    let results = moviesList.results {
                    
                    self.totalPages = moviesList.totalPages
                    
                    self.movies += results.map {
                        return MovieViewModel(movie: $0, genres: self.genres)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func showErrorAlert(error: ServiceError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        let confirm = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _  in
            alert.dismiss(animated: true, completion: nil)
            self.fetchMoviesGenres()
        })
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.tableView.frame = self.view.frame
//        tableView.layoutIfNeeded()
//    }
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
        guard let totalPages = self.totalPages, !isLoading else { return }
        
        if indexPath.row == movies.count - 5 && currentPage <= totalPages {
            isLoading = true
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
