//
//  SongModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

struct SongModel {
    let url: URL
    let name: String
    let album: AlbumModel
    let artistName: String
    let artworkURL: String
    var artwork: UIImage = UIImage(named: "trackImagePlaceholder")!
}
