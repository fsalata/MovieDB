//
//  MoviesTableViewController.swift
//  MovieDB
//
//  Created by Fabio Salata on 12/12/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit

protocol MoviesViewControllerDelegate: AnyObject {
    func setupSearchController(_ viewController: MoviesViewController, searchController: UISearchController)
}

final class MoviesViewController: UIViewController, DataLoading {
    var tableView: UITableView!
    
    var moviesViewModel: MoviesViewModel!
    
    let loadingMore = UIActivityIndicatorView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    weak var delegate: MoviesViewControllerDelegate?
    
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
    
    init(viewModel: MoviesViewModel) {
        moviesViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = UIView()
        
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchMovies(loading: true)
    }
    
    override func viewDidLayoutSubviews() {
        delegate?.setupSearchController(self, searchController: searchController)
    }
    
    // MARK: View and Layout
    
    private func setupLayout() {
        tableView = UITableView(frame: self.view.frame)
        
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        tableView.backgroundColor = backgroundColor
        tableView.backgroundView?.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 280.0
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.setContentOffset(.init(x: 0, y: searchController.searchBar.frame.height), animated: false)
        
        loadingMore.style = UIActivityIndicatorView.Style.white
        loadingMore.frame = .init(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        tableView.tableFooterView = self.loadingMore
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
    }
    
    // MARK: Private methods
    
    @objc private func fetchMovies (loading: Bool = false) {
        if loading {
            self.state = .loading
        }
        
        moviesViewModel.fetch { [weak self] in
            guard let self = self else { return }
            
            self.isLoadingMore = false
            
            guard self.moviesViewModel.error == nil else {
                let error = self.moviesViewModel.error!
                
                DispatchQueue.main.async {
                    self.showErrorView(message: error.localizedDescription)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.state = .loaded(data: self.moviesViewModel.movies)
            }
        }
    }
    
    private func showErrorView(message: String) {
        DispatchQueue.main.async {
            self.state = .error(message)
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
            return moviesViewModel.filteredMovies.count
        }
        
        return moviesViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: MovieCell.self, for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            
            var movie: MovieViewModel

            if self.isFiltering() {
                movie = self.moviesViewModel.filteredMovies[indexPath.row]
            }
            else {
                movie = self.moviesViewModel.movies[indexPath.row]
            }

            cell.movie = movie
        }
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesViewModel.movies[indexPath.row]
        
        moviesViewModel.showMovieDetails(movie: movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalPages = self.moviesViewModel.totalPages, !isLoadingMore else { return }
        
        if indexPath.row == self.moviesViewModel.movies.count - 5 && moviesViewModel.currentPage <= totalPages {
            isLoadingMore = true
            moviesViewModel.currentPage = moviesViewModel.currentPage + 1
            
            fetchMovies(loading: false)
            
            if moviesViewModel.currentPage == totalPages {
                tableView.tableFooterView = UIView(frame: CGRect.zero)
            }
        }
    }
}

//  MARK: UISearchResultsUpdating
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        moviesViewModel.filteredMovies = moviesViewModel.movies.filter({( movie: MovieViewModel) -> Bool in
            return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        
        tableView.reloadData()
    }
}
