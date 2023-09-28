//
//  SongSearchView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

class SongSearchView: UITableViewController {
    
    let viewModel = SongSearchViewModel()
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
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigationBar() {
        title = "Songs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: UI Search Results Updating
extension SongSearchView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchSongs(byTerm: searchText)
    }
    
}

// MARK: UI Table View Data Source
extension SongSearchView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: UITableViewCell.self, for: indexPath) else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.configurationUpdateHandler = { cell, state in
            var content = cell.defaultContentConfiguration().updated(for: state)
            
            content.text = "Something"
            content.textProperties.font = .systemFont(ofSize: 16.0)
            
            content.secondaryText = "Artist"
            content.secondaryTextProperties.color = .systemGray
            content.secondaryTextProperties.font = .systemFont(ofSize: 14.0)
            
            content.image = UIImage(named: "trackImagePlaceholder")
            
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
