//
//  SongsRepositoryInjection.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Foundation

protocol SongsRepositoryInjection {
    var songsRepository: SongsRepository { get }
}

extension SongsRepositoryInjection {
    var songsRepository: SongsRepository {
        return ITunesAPISongsRepository()
    }
}
