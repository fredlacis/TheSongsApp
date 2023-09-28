//
//  SongModel.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

struct SongModel {
    let trackName: String
    let artistName: String
    let songURL: String
    let artworkURL: String
    let albumID: String
    var artwork: UIImage = UIImage(named: "trackImagePlaceholder")!
}
