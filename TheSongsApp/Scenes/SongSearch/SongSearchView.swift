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
        
        ITunesAPISongsRepository().getAlbumSongs(byID: "159292399") { result in
            switch result {
                case .success(let songs):
                    dump(songs)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
        
        ITunesAPISongsRepository().searchSongs(byTerm: "michael") { result in
            switch result {
                case .success(let songs):
                    dump(songs)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
}
