//
//  TSASongTableViewCell.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import UIKit
import Combine

class TSASongTableViewCell: UITableViewCell {
    
    private var viewModel: TSASongTableViewCellViewModel?
    private var subscriptions = Set<AnyCancellable>()
    
    func configure(viewModel: TSASongTableViewCellViewModel) {
        self.viewModel = viewModel
        setupBindings()
        viewModel.updateSongImage()
        setNeedsUpdateConfiguration()
    }
    
    override func prepareForReuse() {
        viewModel = nil
        subscriptions.forEach { $0.cancel() }
        subscriptions = []
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let song = viewModel?.song else { return }
        
        var content = defaultContentConfiguration().updated(for: state)
        
        content.text = song.name
        content.textProperties.font = .systemFont(ofSize: 16.0)
        
        content.secondaryText = song.artistName
        content.secondaryTextProperties.color = .systemGray
        content.secondaryTextProperties.font = .systemFont(ofSize: 14.0)
        
        content.image = song.artwork ?? UIImage(named: "trackImagePlaceholder")
        content.imageProperties.cornerRadius = 8.0
        content.imageProperties.maximumSize = .init(width: 44.0, height: 44.0)
        
        contentConfiguration = content
        selectionStyle = .none
    }
    
    private func setupBindings() {
        viewModel?.$song
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setNeedsUpdateConfiguration()
            }.store(in: &subscriptions)
    }
    
}
