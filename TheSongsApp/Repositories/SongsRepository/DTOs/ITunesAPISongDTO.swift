//
//  ITunesAPISongDTO.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 27/09/23.
//

import Foundation

struct ITunesAPISongDTO: Decodable, DTOProtocol {
    let wrapperType, kind: String
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let primaryGenreName: String

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, primaryGenreName
    }
    
    func map() -> SongModel? {
        guard let songURL =  URL(string: previewURL) else { return nil }
        return SongModel(trackName: trackName,
                         artistName: artistName,
                         songURL: songURL,
                         artworkURL: artworkUrl100,
                         albumID: "\(collectionID)")
    }
}
