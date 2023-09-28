//
//  SongModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import Foundation

struct SongModel: Decodable {
    let trackName: String
    let artistName: String
    let songURL: String
    let artworkURL: String
    let albumID: String
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case songURL = "previewUrl"
        case artworkURL = "artworkUrl100"
        case albumID = "collectionId"
    }
}
