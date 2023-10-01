//
//  SongSearchViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

final class SongSearchViewModel: SongSearchViewModelProtocol {
    
    @Published var songs: [SongModel] = []
    @Published var cellViewModels: [TSASongTableViewCellViewModel] = []
    @Published var isLoading: Bool = false
    
    var songsRepository: SongsRepository
    var imagesRepository: ImagesRepository
    
    private var currentSearchTerm: String = ""
    private var currentLoadedPage: Int = 0
    
    init(songsRepository: SongsRepository, imagesRepository: ImagesRepository) {
        self.songsRepository = songsRepository
        self.imagesRepository = imagesRepository
    }
    
    func searchSongs(byTerm term: String?) {
        currentSearchTerm = term ?? currentSearchTerm
        currentLoadedPage = 0
        isLoading = true
        songsRepository.searchSongs(byTerm: currentSearchTerm, page: currentLoadedPage) { [weak self] result in
            switch result {
                case .success(let songs):
                    guard let self else { return }
                    self.songs = songs
                    self.cellViewModels = songs.map { TSASongTableViewCellViewModel(song: $0, imagesRepository: self.imagesRepository) }
                    self.currentLoadedPage = 1
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
                    let newSongs = songs.filter { !self.songs.contains($0) }
                    let newSongsCellViewModels = newSongs.map { TSASongTableViewCellViewModel(song: $0, imagesRepository: self.imagesRepository) }
                    self.songs.append(contentsOf: newSongs)
                    self.cellViewModels.append(contentsOf: newSongsCellViewModels)
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
