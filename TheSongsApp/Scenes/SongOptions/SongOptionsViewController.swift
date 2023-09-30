//
//  SongOptionsViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import UIKit
import Combine

class SongOptionsViewController: BaseViewController<SongOptionsView> {
    
    var coordinator: SongsCoordinator?
    
    let viewModel: SongOptionsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: SongOptionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargetActions()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSheetPresentationController()
    }
    
}

// MARK: Setup Methods
extension SongOptionsViewController {
    
    private func setupTargetActions() {
        rootView.openAlbumButton.addTarget(self, action: #selector(openAlbumDetails), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.$song
            .receive(on: DispatchQueue.main)
            .sink { [weak self] song in
                self?.rootView.titleLabel.text = song.trackName
                self?.rootView.subtitleLabel.text = song.artistName
            }.store(in: &subscriptions)
    }
    
    private func setupSheetPresentationController() {
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.detents = [
            .custom(resolver: { [weak self] context in
                return self?.rootView.containerView.frame.height
            })
        ]
    }
    
}

// MARK: Setup Methods
extension SongOptionsViewController {
    
    @objc private func openAlbumDetails() {
        coordinator?.presentAlbumDetails(viewModel.song.album)
    }
    
}
