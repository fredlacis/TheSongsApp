//
//  SongModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

struct SongModel: Hashable {
    let id: Int
    let url: URL
    let name: String
    let album: AlbumModel
    let artistName: String
    let artworkURL: URL
    var artwork: UIImage?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SongModel, rhs: SongModel) -> Bool {
        lhs.id == rhs.id
    }
}
