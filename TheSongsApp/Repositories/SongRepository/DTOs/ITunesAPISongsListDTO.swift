//
//  ITunesAPISongsListDTO.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 27/09/23.
//

import Foundation

struct ITunesAPISongsListDTO: Decodable, DTOProtocol {
    var resultCount: Int
    var results: LossyDecodableList<ITunesAPISongDTO>
    
    func map() -> [SongModel]? {
        return results.elements.compactMap { $0.map() }
    }
}
