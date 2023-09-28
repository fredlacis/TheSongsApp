//
//  ITunesAPISongsRepository.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 27/09/23.
//

import Foundation

class ITunesAPISongsRepository: SongsRepository {
    
    private let webService = WebService()

    func searchSongs(byTerm: String, completion: @escaping SongsCompletion) {
        webService.get(type: ITunesAPISongsListDTO.self, ITunesAPIEndpoint.searchMusic(byTerm)) { result in
            switch result {
                case .success(let songsList):
                    completion(.success(songsList.map() ?? []))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getAlbumSongs(byID: String, completion: @escaping SongsCompletion) {
        webService.get(type: ITunesAPISongsListDTO.self, ITunesAPIEndpoint.lookupAlbum(byID)) { result in
            switch result {
                case .success(let songsList):
                    completion(.success(songsList.map() ?? []))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
