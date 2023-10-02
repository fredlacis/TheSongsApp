//
//  PlayerViewModelTests.swift
//  TheSongsAppTests
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import XCTest
import Combine
@testable import TheSongsApp

final class PlayerViewModelTests: XCTestCase {
    
    let mockImagesRepository = MockImagesRepository()
    let musicPlayerService = MusicPlayerService()
    var playerViewModel: PlayerViewModel!
    
    override func setUp() {
        playerViewModel = PlayerViewModel(song: .mock1, imagesRepository: mockImagesRepository, musicPlayer: musicPlayerService)
        playerViewModel.updateCurrentSong()
    }
    
    func test_play() {
        playerViewModel.toggleSongPlaybackState()
        XCTAssertTrue(playerViewModel.isPlaying)
        playerViewModel.toggleSongPlaybackState()
        XCTAssertFalse(playerViewModel.isPlaying)
    }
    
    func test_update_song_playback_time() {
        var subscriptions = Set<AnyCancellable>()
        
        XCTAssertEqual(playerViewModel.currentSongPlaybackTime, 0.0)
        
        var firstCall = true
        
        let currentSongPlaybackTimeExpectation = expectation(description: "Successfully sink current playback time")
        playerViewModel.$currentSongPlaybackTime
            .dropFirst()
            .sink { currentSongPlaybackTime in
                if firstCall {
                    self.playerViewModel.updateSongPlaybackTime(to: 15.0)
                    firstCall = false
                    return
                }
                XCTAssertEqual(currentSongPlaybackTime, 15.0)
                currentSongPlaybackTimeExpectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [currentSongPlaybackTimeExpectation])
    }
    
    func test_skip_time() {
        var subscriptions = Set<AnyCancellable>()
        
        XCTAssertEqual(playerViewModel.currentSongPlaybackTime, 0.0)
        
        var firstCall = true
        
        let currentSongPlaybackTimeExpectation = expectation(description: "Successfully sink current playback time")
        playerViewModel.$currentSongPlaybackTime
            .dropFirst()
            .sink { currentSongPlaybackTime in
                if firstCall {
                    self.playerViewModel.skipTime(.forward)
                    firstCall = false
                    return
                }
                XCTAssertEqual(currentSongPlaybackTime, Float(TimeMovingDirection.forward.seconds))
                currentSongPlaybackTimeExpectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [currentSongPlaybackTimeExpectation])
    }
    
    func test_get_song_artwork() {
        var subscriptions = Set<AnyCancellable>()
        
        let songArtworkExpectation = expectation(description: "Successfully sink current playback time")
        playerViewModel.$song
            .dropFirst()
            .sink { song in
                XCTAssertNotNil(song.artwork)
                songArtworkExpectation.fulfill()
            }.store(in: &subscriptions)
        
        playerViewModel.getSongArtwork()
        
        wait(for: [songArtworkExpectation])
    }
    
}
