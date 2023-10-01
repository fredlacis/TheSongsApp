//
//  SongSearchViewModelProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

protocol SongSearchViewModelProtocol: SongsRepositoryInjection, ImagesRepositoryInjection {
    
    var songs: [SongModel] { get set }
    var cellViewModels: [TSASongTableViewCellViewModel] { get set }
    var isLoading: Bool { get set }
    
    func searchSongs(byTerm term: String?)
    func loadNextPage()
    func prefetchSongArtwork(atIndex index: Int)
    
}
