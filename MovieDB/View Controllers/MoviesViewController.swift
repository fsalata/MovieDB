//
//  MoviesTableViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    var collectionView: UICollectionView!
    
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
    
    let cellID = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupLayout()
        
        fetchMoviesGenres()
    }
    
    private func setupView() {
        title = "Upcoming movies"
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.bounds.width - 20.0, height: 250)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.backgroundColor = UIColor(r: 42, g: 42, b: 42)
        
        self.view.addSubview(collectionView)

//        let backgroundColor = UIColor(r: 42, g: 42, b: 42)
//        tableView.backgroundColor = backgroundColor
//        tableView.backgroundView?.backgroundColor = backgroundColor
//
//        loadingMore.style = UIActivityIndicatorView.Style.white
//        loadingMore.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
//        tableView.tableFooterView = self.loadingMore
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Movies"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
    }
    
    // MARK: Private methods
    private func setupLayout() {
        collectionView.pinEdgesToSuperview()
    }
    
    private func fetchMoviesGenres() {
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
                    
                    self.collectionView.reloadData()
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
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetails" {
            if let destinationViewController = segue.destination as? MovieDetailsViewController {

                var movie: MovieViewModel
                
                guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }

                if isFiltering() {
                    movie = filteredMovies[indexPath.row]
                }
                else {
                    movie = movies[indexPath.row]
                }

                destinationViewController.movie = movie
            }
        }
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        coordinator.animate(alongsideTransition: { context in
//            if UIApplication.shared.statusBarOrientation.isLandscape {
//                self.tableView.estimatedRowHeight = 305.0
//            } else {
//                self.tableView.estimatedRowHeight = 213.0
//            }
//        })
//
//        tableView.reloadData()
//    }
}

//  MARK: UICollectionView data source
extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCollectionViewCell
        
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

//  MARK: UICollectionView delegate
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movies[indexPath.row]
        
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

//  MARK: UISearchResultsUpdating
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        filteredMovies = movies.filter({( movie: MovieViewModel) -> Bool in
            return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
        })

        collectionView.reloadData()
    }
}
