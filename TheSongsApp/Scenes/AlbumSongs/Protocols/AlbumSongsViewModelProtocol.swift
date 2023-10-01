//
//  AlbumSongsViewModelProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

protocol AlbumSongsViewModelProtocol: SongsRepositoryInjection, ImagesRepositoryInjection {
    
    var album: AlbumModel { get set }
    var cellViewModels: [TSASongTableViewCellViewModel] { get set }
    
    func getAlbumSongs()
    
}
