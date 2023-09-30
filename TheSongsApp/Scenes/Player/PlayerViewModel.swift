//
//  PlayerViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Combine
import CoreMedia

final class PlayerViewModel {
    
    private let musicPlayer = MusicPlayerService()
    
    @Published var song: SongModel
    @Published var isPlaying: Bool = false
    @Published var ellapsedSongTime: String = ""
    @Published var remainingSongTime: String = ""
    @Published var currentSongPlaybackTime: Float = 0.0
    @Published var totalSongTime: Float = 0.0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(song: SongModel) {
        self.song = song
        musicPlayer.currentSong = song
        setupServiceBindings()
    }
    
    func toggleSongPlaybackState() {
        isPlaying ? musicPlayer.pause() : musicPlayer.play()
    }
    
    func updateSongPlaybackTime(to seconds: Float) {
        musicPlayer.updateCurrentTime(to: seconds)
    }
    
    private func setupServiceBindings() {
        musicPlayer.$songDuration.combineLatest(musicPlayer.$currentSongPlaybackTime)
            .sink { [weak self] songDuration, currentSongPlaybackTime in
                let songDurationSeconds = CMTimeGetSeconds(songDuration)
                let currentSongPlaybackTimeSeconds = CMTimeGetSeconds(currentSongPlaybackTime)
                let remainingSongTimeSeconds = songDurationSeconds - currentSongPlaybackTimeSeconds
                
                self?.currentSongPlaybackTime = Float(currentSongPlaybackTimeSeconds)
                self?.ellapsedSongTime = currentSongPlaybackTimeSeconds.formattedAsHourMinSec
                self?.remainingSongTime = "-\(remainingSongTimeSeconds.formattedAsHourMinSec)"
                self?.totalSongTime = Float(songDurationSeconds)
            }
            .store(in: &subscriptions)
        
        musicPlayer.$isPlaying.assign(to: &$isPlaying)
    }
    
}
