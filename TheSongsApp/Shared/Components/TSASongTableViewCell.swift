//
//  TSASongTableViewCell.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import UIKit

class TSASongTableViewCell: UITableViewCell {
    
    var song: SongModel?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let song else { return }
        
        var content = defaultContentConfiguration().updated(for: state)
        
        content.text = song.trackName
        content.textProperties.font = .systemFont(ofSize: 16.0)
        
        content.secondaryText = song.artistName
        content.secondaryTextProperties.color = .systemGray
        content.secondaryTextProperties.font = .systemFont(ofSize: 14.0)
        
        content.image = song.artwork
        content.imageProperties.cornerRadius = 8.0
        content.imageProperties.maximumSize = .init(width: 44.0, height: 44.0)
        
        contentConfiguration = content
        selectionStyle = .none
    }
    
}
