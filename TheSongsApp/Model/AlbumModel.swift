//
//  AlbumModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import Foundation

struct AlbumModel {
    let albumID: String
    let albumName: String
    var songs: [SongModel] = []
}
