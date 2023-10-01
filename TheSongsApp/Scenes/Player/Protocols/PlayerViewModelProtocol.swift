//
//  PlayerViewModelProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

protocol PlayerViewModelProtocol: ImagesRepositoryInjection {
    
    var song: SongModel { get set }
    var isPlaying: Bool { get set }
    var ellapsedSongTime: String { get set }
    var remainingSongTime: String { get set }
    var currentSongPlaybackTime: Float { get set }
    var totalSongTime: Float { get set }
    
    func updateCurrentSong()
    func toggleSongPlaybackState()
    func updateSongPlaybackTime(to seconds: Float)
    func skipTime(_ direction: TimeMovingDirection)
    func getSongArtwork()
    
}
