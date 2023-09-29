//
//  PlayerViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Foundation

final class PlayerViewModel {
    
    @Published var song: SongModel
    
    init(song: SongModel) {
        self.song = song
    }
    
}
