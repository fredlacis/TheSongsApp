//
//  PlayerViewModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Combine
import CoreMedia

final class PlayerViewModel: PlayerViewModelProtocol {
    
    private let musicPlayer: MusicPlayerService
    
    @Published var song: SongModel
    @Published var isPlaying: Bool = false
    @Published var ellapsedSongTime: String = ""
    @Published var remainingSongTime: String = ""
    @Published var currentSongPlaybackTime: Float = 0.0
    @Published var totalSongTime: Float = 0.0
    
    var imagesRepository: ImagesRepository
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(song: SongModel, imagesRepository: ImagesRepository, musicPlayer: MusicPlayerService) {
        self.song = song
        self.imagesRepository = imagesRepository
        self.musicPlayer = musicPlayer
        setupServiceBindings()
        getSongArtwork()
    }
    
    func updateCurrentSong() {
        musicPlayer.currentSong = song
    }
    
    func toggleSongPlaybackState() {
        isPlaying ? musicPlayer.pause() : musicPlayer.play()
    }
    
    func updateSongPlaybackTime(to seconds: Float) {
        musicPlayer.updateCurrentTime(to: seconds)
    }
    
    func skipTime(_ direction: TimeMovingDirection) {
        musicPlayer.skipTime(direction)
    }
    
    func getSongArtwork() {
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

// MARK: Setup Methods
extension PlayerViewModel {
    
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
