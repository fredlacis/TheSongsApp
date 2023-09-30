//
//  SongOptionsViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import Foundation

final class SongOptionsViewModel {
    
    @Published var song: SongModel
    
    init(song: SongModel) {
        self.song = song
    }
    
}
