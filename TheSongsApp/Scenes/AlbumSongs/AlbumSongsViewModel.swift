//
//  AlbumSongsViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import Foundation

final class AlbumSongsViewModel: SongsRepositoryInjection, ImagesRepositoryInjection {
    
    @Published var album: AlbumModel
    
    init(album: AlbumModel) {
        self.album = album
        getAlbumSongs()
    }
    
    func getAlbumSongs() {
        songsRepository.getAlbumSongs(byID: album.id) { [weak self] result in
            switch result {
                case .success(let songs):
                    self?.album.songs = songs
                    self?.downloadSongsArtworks()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func downloadSongsArtworks() {
        for (index, song) in album.songs.enumerated() {
            imagesRepository.loadImage(from: song.artworkURL) { [weak self] result in
                switch result {
                    case .success(let image):
                        guard index < (self?.album.songs.count ?? 0) else { break }
                        self?.album.songs[index].artwork = image
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        }
    }
    
}
