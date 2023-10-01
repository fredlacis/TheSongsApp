//
//  SongsRepository.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import Foundation

protocol SongsRepository {
    
    typealias SongsCompletion = (Result<[SongModel], Error>) -> Void
    
    func searchSongs(byTerm: String, page: Int, completion: @escaping SongsCompletion)
    
    func getAlbumSongs(byID: String, completion: @escaping SongsCompletion)
    
}
