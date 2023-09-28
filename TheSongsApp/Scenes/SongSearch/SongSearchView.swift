//
//  SongSearchView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit
import Combine

class SongSearchView: UITableViewController {
    
    private let viewModel = SongSearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: Setup Methods
extension SongSearchView {
    
    private func setupView() {
        setupTableView()
        setupSearchController()
        setupNavigationBar()
        setupBindings()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self)
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
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: UI Search Results Updating & UI Search Controller Delegate
extension SongSearchView: UISearchResultsUpdating, UISearchBarDelegate {
    
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
extension SongSearchView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: UITableViewCell.self, for: indexPath) else { return UITableViewCell() }
        
        let song = viewModel.songs[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.configurationUpdateHandler = { cell, state in
            var content = cell.defaultContentConfiguration().updated(for: state)
            
            content.text = song.trackName
            content.textProperties.font = .systemFont(ofSize: 16.0)
            
            content.secondaryText = song.artistName
            content.secondaryTextProperties.color = .systemGray
            content.secondaryTextProperties.font = .systemFont(ofSize: 14.0)
            
            content.image = song.artwork
            content.imageProperties.cornerRadius = 8.0
            content.imageProperties.maximumSize = .init(width: 44.0, height: 44.0)
            
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
}

// MARK: UI Table View Delegate
extension SongSearchView {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
