//
//  MoviesTableViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

final class UpcomingMoviesViewController: UIViewController, DataLoading {
    var coordinator: UpcomingMoviesCoordinator!
    var viewModel: UpcomingMoviesViewModel!
    
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
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
    
    init(viewModel: UpcomingMoviesViewModel, coordinator: UpcomingMoviesCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = UIView()
        
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming Movies"
        
        setupView()
        
        fetchMovies(loading: true)
    }
    
    // MARK: View and Layout
    private func setupLayout() {
        self.view.addSubview(tableView)
        
        tableView.pinEdgesToSuperview()
        
        self.view.addSubviews(loadingView, errorView)
        
        loadingView.pinEdgesToSuperview()
        errorView.pinEdgesToSuperview()
    }
    
    private func setupView() {
        let backgroundColor = UIColor(r: 2, g: 34, b: 67)
        
        loadingView.backgroundColor = backgroundColor
        errorView.backgroundColor = backgroundColor
        
        errorView.button.setTitle("Try again?", for: .normal)
        errorView.button.addTarget(self, action: #selector(fetchMovies(loading:)), for: .touchUpInside)
        
        setupTableView(backgroundColor)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView(_ backgroundColor: UIColor) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        tableView.backgroundColor = backgroundColor
        tableView.backgroundView?.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 280.0
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.setContentOffset(.init(x: 0, y: searchController.searchBar.frame.height), animated: false)
    }
    
    // MARK: Private methods
    @objc private func fetchMovies (loading: Bool = false) {
        if loading {
            self.state = .loading
        }
        
        viewModel.fetchMovies()
    }
    
    private func showErrorView(message: String) {
        DispatchQueue.main.async {
            self.state = .error(message)
        }
    }
}

extension UpcomingMoviesViewController: UpcomingMoviesViewModelDelegate {
    func upcomingMoviesViewModelDidFetchMoviesSuccess(viewModel: UpcomingMoviesViewModel) {
        DispatchQueue.main.async {
            self.state = .loaded(data: self.viewModel.movies)
        }
    }
    
    func upcomingMoviesViewModel(viewModel: UpcomingMoviesViewModel, fetchMoviesFailedWithError error: APIError) {
        self.showErrorView(message: error.localizedDescription)
    }
}

extension UpcomingMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredMovies.count
        }
        
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: MovieCell.self, for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            
            var movie: MovieViewModel

            if self.isFiltering {
                movie = self.viewModel.filteredMovies[indexPath.row]
            }
            else {
                movie = self.viewModel.movies[indexPath.row]
            }

            cell.movie = movie
        }
        
        return cell
    }
}

extension UpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        coordinator.presentMovieDetails(movie: movie)
    }
}

extension UpcomingMoviesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard case ViewState.loaded(_) = state,
              (indexPaths.contains { $0.row >= self.viewModel.movies.count - 1 }) else {
            return
        }
        
        viewModel.fetchMovies()
    }
}

//  MARK: UISearchResultsUpdating
extension UpcomingMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        viewModel.filteredMovies = viewModel.movies.filter({( movie: MovieViewModel) -> Bool in
            return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        
        tableView.reloadData()
    }
}
