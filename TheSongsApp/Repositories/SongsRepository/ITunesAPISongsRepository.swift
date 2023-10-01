//
//  ITunesAPISongsRepository.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 27/09/23.
//

import Foundation

final class ITunesAPISongsRepository: SongsRepository, WebServiceInjection {

    func searchSongs(byTerm: String, page: Int, completion: @escaping SongsCompletion) {
        let limit = 15
        let offset = page * limit
        webService.send(type: ITunesAPISongsListDTO.self, ITunesAPIEndpoint.searchMusic(byTerm, limit: limit, offset: offset)) { result in
            switch result {
                case .success(let songsList):
                    completion(.success(songsList.map() ?? []))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getAlbumSongs(byID: String, completion: @escaping SongsCompletion) {
        webService.send(type: ITunesAPISongsListDTO.self, ITunesAPIEndpoint.lookupAlbum(byID)) { result in
            switch result {
                case .success(let songsList):
                    completion(.success(songsList.map() ?? []))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
