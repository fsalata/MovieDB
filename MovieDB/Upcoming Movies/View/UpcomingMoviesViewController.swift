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
    
    var dataSource: UITableViewDiffableDataSource<Int, MovieViewModel>!
    
    // MARK - Data loading protocol
    var loadingView: LoadingView = LoadingView()
    var errorView: ErrorView = ErrorView()
    
    var state: ViewState<[MovieViewModel]> = .loading {
        didSet {
            update()
            refreshDataSource()
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
    }
    
    private func setupTableView(_ backgroundColor: UIColor) {
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        
        dataSource = UITableViewDiffableDataSource<Int, MovieViewModel>(tableView: tableView, cellProvider: {[weak self] tableView, indexPath, movie in
            guard let self = self else { return  UITableViewCell()}
            
            let cell = tableView.dequeueCell(of: MovieCell.self, for: indexPath) { [weak self] cell in
                guard let self = self else { return }
                
                var movie: MovieViewModel
                
                movie = self.viewModel.movies[indexPath.row]
                
                cell.movie = movie
            }
            
            return cell
        })
        
        tableView.backgroundColor = backgroundColor
        tableView.backgroundView?.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 280.0
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: Private methods
    @objc private func fetchMovies (loading: Bool = false) {
        if loading {
            self.state = .loading
        }
        
        viewModel.fetchMovies()
    }
    
    private func refreshDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MovieViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.movies)
        dataSource.apply(snapshot)
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
