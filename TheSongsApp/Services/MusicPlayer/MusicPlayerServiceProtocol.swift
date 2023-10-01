//
//  MusicPlayerServiceProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import CoreMedia

protocol MusicPlayerServiceProtocol {
    
    var currentSong: SongModel? { get set }
    var isPlaying: Bool { get set }
    var songDuration: CMTime { get set }
    var currentSongPlaybackTime: CMTime { get set }
    
    func play()
    func pause()
    func updateCurrentTime(to seconds: Float)
    func skipTime(_ direction: TimeMovingDirection)
    
}
