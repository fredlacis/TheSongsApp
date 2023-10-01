//
//  SongSearchViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

final class SongSearchViewModel: SongsRepositoryInjection, ImagesRepositoryInjection {
    
    @Published var songs: [SongModel] = []
    @Published var isLoading: Bool = false
    
    var currentSearchTerm: String = ""
    var currentLoadedPage: Int = 0
    
    func searchSongs(byTerm term: String) {
        currentSearchTerm = term
        currentLoadedPage = 0
        isLoading = true
        songsRepository.searchSongs(byTerm: term, page: currentLoadedPage) { [weak self] result in
            switch result {
                case .success(let songs):
                    self?.songs = songs
                    self?.currentLoadedPage = 1
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
            self?.isLoading = false
        }
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        songsRepository.searchSongs(byTerm: currentSearchTerm, page: currentLoadedPage) { [weak self] result in
            switch result {
                case .success(let songs):
                    guard let self else { return }
                    self.songs.append(contentsOf: songs.filter { !self.songs.contains($0) })
                    self.currentLoadedPage += 1
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
            self?.isLoading = false
        }
    }
    
    func prefetchSongArtwork(atIndex index: Int) {
        guard index < songs.count, songs[index].artwork == nil else { return }
        imagesRepository.loadImage(from: songs[index].artworkURL) { [weak self] result in
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
