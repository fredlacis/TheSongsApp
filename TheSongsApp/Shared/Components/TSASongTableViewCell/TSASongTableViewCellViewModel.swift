//
//  TSASongTableViewCellViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

final class TSASongTableViewCellViewModel: ImagesRepositoryInjection {

    @Published var song: SongModel?
    
    func updateSongImage() {
        guard let song else { return }
        imagesRepository.loadImage(from: song.artworkURL) { [weak self] result in
            switch result {
                case .success(let image):
                    self?.song?.artwork = image
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
}
