//
//  SongModel.swift
//  TheSongsAppTests
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation
@testable import TheSongsApp

internal extension SongModel {
    
    static var mock1 = SongModel(id: 159293734,
                                 url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/fb/36/2e/fb362ee4-0830-ac20-ece5-9dbe71c21fd1/mzaf_6272694586558051182.plus.aac.p.m4a")!,
                                 name: "The Girl Is Mine",
                                 album: AlbumModel(id: 159292399, name: "The Essential Michael Jackson"),
                                 artistName: "Michael Jackson",
                                 artworkURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/3d/9d/38/3d9d3811-71f0-3a0e-1ada-3004e56ff852/827969428726.jpg/100x100bb.jpg")!)
    
    static var mock2 = SongModel(id: 159295575,
                                 url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/71/0b/ce/710bce59-f1a6-a06c-4d28-d4055e674870/mzaf_14615073307162522309.plus.aac.p.m4a")!,
                                 name: "In the Closet",
                                 album: AlbumModel(id: 159292399, name: "The Essential Michael Jackson"),
                                 artistName: "Michael Jackson",
                                 artworkURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/3d/9d/38/3d9d3811-71f0-3a0e-1ada-3004e56ff852/827969428726.jpg/100x100bb.jpg")!)
    
}
