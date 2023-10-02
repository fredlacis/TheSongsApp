//
//  SongSearchViewModelTests.swift
//  TheSongsAppTests
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import XCTest
import Combine
@testable import TheSongsApp

final class SongSearchViewModelTests: XCTestCase {
    
    let mockSongsRepository = MockSongsRepository()
    let mockImagesRepository = MockImagesRepository()
    var songSearchViewModel: SongSearchViewModel!
    
    override func setUp() {
        songSearchViewModel = SongSearchViewModel(songsRepository: mockSongsRepository, imagesRepository: mockImagesRepository)
    }

    func test_search_songs_success() {
        var subscriptions = Set<AnyCancellable>()
        
        let songsExpectation = expectation(description: "Successfully sink songs")
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertFalse(songs.isEmpty)
                songsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        let cellViewModelsExpectation = expectation(description: "Successfully sink cell view models")
        songSearchViewModel.$cellViewModels
            .dropFirst()
            .sink { cellViewModels in
                XCTAssertFalse(cellViewModels.isEmpty)
                cellViewModelsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        XCTAssertTrue(songSearchViewModel.songs.isEmpty)
        XCTAssertTrue(songSearchViewModel.cellViewModels.isEmpty)
        
        songSearchViewModel.searchSongs(byTerm: "search term")
        
        wait(for: [songsExpectation, cellViewModelsExpectation])
    }
    
    func test_search_songs_fail() {
        var subscriptions = Set<AnyCancellable>()
        
        mockSongsRepository.shouldReturnError = true
        
        let songsExpectation = expectation(description: "Songs are never updated")
        songsExpectation.isInverted = true
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertFalse(songs.isEmpty)
                songsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        let cellViewModelsExpectation = expectation(description: "Cell View Models are never updated")
        cellViewModelsExpectation.isInverted = true
        songSearchViewModel.$cellViewModels
            .dropFirst()
            .sink { cellViewModels in
                XCTAssertFalse(cellViewModels.isEmpty)
                cellViewModelsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        XCTAssertTrue(songSearchViewModel.songs.isEmpty)
        XCTAssertTrue(songSearchViewModel.cellViewModels.isEmpty)
        
        songSearchViewModel.searchSongs(byTerm: "search term")
        
        wait(for: [songsExpectation, cellViewModelsExpectation], timeout: 1.0)
    }
    
    func test_load_next_page() {
        var subscriptions = Set<AnyCancellable>()
        
        let songsExpectation = expectation(description: "Successfully sink songs")
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertFalse(songs.isEmpty)
                songsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        let cellViewModelsExpectation = expectation(description: "Successfully sink cell view models")
        songSearchViewModel.$cellViewModels
            .dropFirst()
            .sink { cellViewModels in
                XCTAssertFalse(cellViewModels.isEmpty)
                cellViewModelsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        XCTAssertTrue(songSearchViewModel.songs.isEmpty)
        XCTAssertTrue(songSearchViewModel.cellViewModels.isEmpty)
        
        songSearchViewModel.loadNextPage()
        
        wait(for: [songsExpectation, cellViewModelsExpectation])
    }
    
    func test_load_next_page_fail() {
        var subscriptions = Set<AnyCancellable>()
        
        mockSongsRepository.shouldReturnError = true
        
        let songsExpectation = expectation(description: "Songs are never updated")
        songsExpectation.isInverted = true
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertFalse(songs.isEmpty)
                songsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        let cellViewModelsExpectation = expectation(description: "Cell View Models are never updated")
        cellViewModelsExpectation.isInverted = true
        songSearchViewModel.$cellViewModels
            .dropFirst()
            .sink { cellViewModels in
                XCTAssertFalse(cellViewModels.isEmpty)
                cellViewModelsExpectation.fulfill()
            }.store(in: &subscriptions)
        
        XCTAssertTrue(songSearchViewModel.songs.isEmpty)
        XCTAssertTrue(songSearchViewModel.cellViewModels.isEmpty)
        
        songSearchViewModel.loadNextPage()
        
        wait(for: [songsExpectation, cellViewModelsExpectation], timeout: 1.0)
    }
    
    func test_prefetch_song_artwork() {
        var subscriptions = Set<AnyCancellable>()
        
        songSearchViewModel.searchSongs(byTerm: "search term")
        
        let songArtworkExpectation = expectation(description: "Successfully sink song with first artwork filled")
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertNotNil(songs.first?.artwork)
                songArtworkExpectation.fulfill()
            }.store(in: &subscriptions)
        
        songSearchViewModel.prefetchSongArtwork(atIndex: 0)
        
        wait(for: [songArtworkExpectation])
    }

    
    func test_prefetch_song_artwork_fail() {
        var subscriptions = Set<AnyCancellable>()
        
        mockImagesRepository.shouldReturnError = true
        
        songSearchViewModel.searchSongs(byTerm: "search term")
        
        let songArtworkExpectation = expectation(description: "Never sinks song with first artwork filled")
        songArtworkExpectation.isInverted = true
        songSearchViewModel.$songs
            .dropFirst()
            .sink { songs in
                XCTAssertNil(songs.first?.artwork)
                songArtworkExpectation.fulfill()
            }.store(in: &subscriptions)
        
        songSearchViewModel.prefetchSongArtwork(atIndex: 0)
        
        wait(for: [songArtworkExpectation], timeout: 1.0)
    }
    
}
