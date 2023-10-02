//
//  AlbumModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import Foundation

struct AlbumModel {
    let id: Int
    let name: String
    var songs: [SongModel] = []
}
