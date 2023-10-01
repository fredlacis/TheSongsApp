//
//  TSASongTableViewCellViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

final class TSASongTableViewCellViewModel: TSASongTableViewCellViewModelProtocol {
    
    @Published var song: SongModel
    
    var imagesRepository: ImagesRepository
    
    init(song: SongModel, imagesRepository: ImagesRepository) {
        self.song = song
        self.imagesRepository = imagesRepository
    }
    
    func updateSongImage() {
        imagesRepository.loadImage(from: song.artworkURL) { [weak self] result in
            switch result {
                case .success(let image):
                    self?.song.artwork = image
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
}
