//
//  AlbumSongsViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import Foundation

final class AlbumSongsViewModel: AlbumSongsViewModelProtocol {
    
    @Published var album: AlbumModel
    @Published var cellViewModels: [TSASongTableViewCellViewModel] = []
    
    var songsRepository: SongsRepository
    var imagesRepository: ImagesRepository
    
    init(album: AlbumModel, songsRepository: SongsRepository, imagesRepository: ImagesRepository) {
        self.album = album
        self.songsRepository = songsRepository
        self.imagesRepository = imagesRepository
        getAlbumSongs()
    }
    
    func getAlbumSongs() {
        songsRepository.getAlbumSongs(byID: album.id) { [weak self] result in
            switch result {
                case .success(let songs):
                    guard let self else { return }
                    self.album.songs = songs
                    self.cellViewModels = songs.map { TSASongTableViewCellViewModel(song: $0, imagesRepository: self.imagesRepository) }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
}
