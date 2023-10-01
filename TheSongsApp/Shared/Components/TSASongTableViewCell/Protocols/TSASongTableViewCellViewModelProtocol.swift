//
//  TSASongTableViewCellViewModelProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

protocol TSASongTableViewCellViewModelProtocol: ImagesRepositoryInjection {
    
    var song: SongModel { get set }
    
    func updateSongImage()
    
}
