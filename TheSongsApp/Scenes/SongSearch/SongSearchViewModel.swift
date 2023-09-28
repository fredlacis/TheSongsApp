//
//  SongSearchViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import Foundation

final class SongSearchViewModel {
    
    var songs: [SongModel] = []
    
    func searchSongs(byTerm term: String) {
        ITunesAPISongsRepository().searchSongs(byTerm: term) { result in
            switch result {
                case .success(let songs):
                    dump(songs)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
}
