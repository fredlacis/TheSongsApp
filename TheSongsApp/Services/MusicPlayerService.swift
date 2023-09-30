//
//  MusicPlayerService.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import AVFoundation
import Combine

class MusicPlayerService {
    
    @Published var currentSong: SongModel?
    @Published var isPlaying: Bool = false
    @Published var songDuration: CMTime = CMTime.zero
    @Published var currentSongPlaybackTime: CMTime = CMTime.zero
    
    var songsList: [SongModel] = []
    
    private var player = AVPlayer()
    
    private var session = AVAudioSession.sharedInstance()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupBindings()
        setupAudioSessionCategory()
    }
    
    func play() {
        toggleAudioSession(setValue: true)
        if player.currentTime() == songDuration { player.seek(to: .zero) }
        player.play()
    }
    
    func pause() {
        toggleAudioSession(setValue: false)
        player.pause()
    }
    
    func updateCurrentTime(to seconds: Float) {
        let seconds: Int64 = Int64(seconds)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        if player.rate == 0 {
            player.play()
        }
    }
    
}

// MARK: Private Helper Methods
extension MusicPlayerService {
    
    private func toggleAudioSession(setValue value: Bool) {
        try? session.setActive(value)
    }
    
    private func setupPlayer(withSong song: SongModel?) {
        guard let song else { return }
        let playerItem = AVPlayerItem(url: song.songURL)
        player.replaceCurrentItem(with: playerItem)
        player.volume = 1.0
        
        setupSongDuration()
        setupCurrentTimeObserver()
        setupIsPlayingPublisher()
    }

    private func setupSongDuration() {
        Task {
            let songDuration = try? await player.currentItem?.asset.load(.duration)
            self.songDuration = songDuration ?? CMTime.zero
        }
    }
    
    private func setupCurrentTimeObserver() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
                                       queue: .global(qos: .background)) { [weak self] _ in
            guard let currentTime = self?.player.currentTime() else { return }
            self?.currentSongPlaybackTime = currentTime
        }
    }
    
    private func setupIsPlayingPublisher() {
        player.publisher(for: \.rate)
            .removeDuplicates()
            .sink { [weak self] rate in
                self?.isPlaying = rate != 0
            }.store(in: &subscriptions)
    }
    
    private func setupBindings() {
        $currentSong
            .sink { [weak self] song in
                self?.setupPlayer(withSong: song)
            }
            .store(in: &subscriptions)
    }
    
    private func setupAudioSessionCategory() {
        try? session.setCategory(.playback, mode: .default)
    }
    
}
