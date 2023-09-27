//
//  SongSearchView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

class SongSearchView: UITableViewController {
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
    }
    
}
