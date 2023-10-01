//
//  SongSearchViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit
import Combine

class SongSearchViewController: UITableViewController {
    
    var coordinator: SongsCoordinator?

    private let viewModel = SongSearchViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var diffableDataSource: UITableViewDiffableDataSource<Int, SongModel>?
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: Setup Methods
extension SongSearchViewController {
    
    private func setupView() {
        setupTableView()
        setupTargetActions()
        setupNavigationBar()
        setupSearchController()
        setupBindings()
    }
    
    private func setupTableView() {
        tableView.register(TSASongTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.prefetchDataSource = self
        refreshControl = UIRefreshControl()
        tableViewDiffableDataSource()
        tableView.dataSource = diffableDataSource
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigationBar() {
        title = "Songs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTargetActions() {
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    private func setupActivityIndicatorFooterView(isLoading: Bool) {
        guard isLoading else {
            tableView.tableFooterView = nil
            return
        }
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        tableView.tableFooterView = activityIndicatorView
    }
    
    private func setupBindings() {
        viewModel.$songs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] songs in
                var diffableSnapshot = NSDiffableDataSourceSnapshot<Int, SongModel>()
                diffableSnapshot.appendSections([0])
                diffableSnapshot.appendItems(songs)
                self?.diffableDataSource?.apply(diffableSnapshot)
            }
            .store(in: &subscriptions)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.setupActivityIndicatorFooterView(isLoading: isLoading)
                self?.refreshControl?.endRefreshing()
            }
            .store(in: &subscriptions)
    }
    
}

// MARK: UI Search Results Updating & UI Search Controller Delegate
extension SongSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        viewModel.searchSongs(byTerm: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchController.isActive = false
    }
    
}

// MARK: UI Table View Delegate
extension SongSearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.selectSong(viewModel.songs[indexPath.row])
    }
    
}

// MARK: UI Table View Diffable Data Source
extension SongSearchViewController {
    
    private func tableViewDiffableDataSource() {
        diffableDataSource = UITableViewDiffableDataSource<Int, SongModel>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(ofType: TSASongTableViewCell.self, for: indexPath),
                  let song = self?.viewModel.songs[indexPath.row] else { return UITableViewCell() }
            cell.configure(withSong: song)
            return cell
        }
    }
    
}

// MARK: UI Table View Data Source Prefetching
extension SongSearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { viewModel.prefetchSongArtwork(atIndex: $0.row) }
    }
    
}

// MARK: UI Scroll View Delegate
extension SongSearchViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isBoucingOnBottom else { return }
        viewModel.loadNextPage()
    }
    
}

// MARK: @objc Methods
extension SongSearchViewController {
    
    @objc private func pullToRefresh() {
        viewModel.searchSongs(byTerm: nil)
    }
    
}
