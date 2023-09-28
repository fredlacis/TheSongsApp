//
//  SongSearchViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

final class SongSearchViewModel: SongsRepositoryInjection, ImagesRepositoryInjection {
    
    @Published var songs: [SongModel] = []
    
    func searchSongs(byTerm term: String) {
        songsRepository.searchSongs(byTerm: term) { [weak self] result in
            switch result {
                case .success(let songs):
                    self?.songs = songs
                    self?.downloadSongsArtworks()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    func downloadSongsArtworks() {
        for (index, song) in songs.enumerated() {
            imagesRepository.loadImage(from: song.artworkURL) { [weak self] result in
                switch result {
                    case .success(let image):
                        guard index < (self?.songs.count ?? 0) else { break }
                        self?.songs[index].artwork = image
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        }
    }
    
}
