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
        setupSearchController()
        setupNavigationBar()
        setupBindings()
    }
    
    private func setupTableView() {
        tableView.register(TSASongTableViewCell.self)
        tableView.separatorStyle = .none
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
    
    private func setupBindings() {
        viewModel.$songs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] songs in
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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

// MARK: UI Table View Data Source
extension SongSearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: TSASongTableViewCell.self, for: indexPath) else { return UITableViewCell() }
        cell.song = viewModel.songs[indexPath.row]
        cell.setNeedsUpdateConfiguration()
        return cell
    }
    
}

// MARK: UI Table View Delegate
extension SongSearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.selectSong(viewModel.songs[indexPath.row])
    }
    
}
