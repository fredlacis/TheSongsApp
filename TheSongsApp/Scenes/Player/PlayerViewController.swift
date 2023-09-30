//
//  PlayerViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit
import Combine
//import CoreMedia

class PlayerViewController: BaseViewController<PlayerView> {
    
    let viewModel: PlayerViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: Setup Methods
extension PlayerViewController {
    
    private func setupView() {
        setupOptionsButton()
        setupTargetActions()
        setupBindings()
    }
    
    private func setupOptionsButton() {
        guard let ellipsisImage = UIImage(systemName: "ellipsis"),
              let ellipsisCGImage = ellipsisImage.cgImage else { return }
        let verticalEllipsisImage = UIImage(cgImage: ellipsisCGImage, scale: ellipsisImage.scale, orientation: .right)
            .withTintColor(.label)
            .withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: verticalEllipsisImage, style: .plain, target: nil, action: nil)
    }
    
    private func setupTargetActions() {
        rootView.playPauseButton.addTarget(self, action: #selector(toggleSongPlaybackState), for: .touchUpInside)
        rootView.timelineSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.$song
            .receive(on: DispatchQueue.main)
            .sink { [weak self] song in
                self?.rootView.artworkImageView.image = song.artwork
                self?.rootView.titleLabel.text = song.trackName
                self?.rootView.artistLabel.text = song.artistName
            }.store(in: &subscriptions)
        
        viewModel.$isPlaying
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPlaying in
                let buttonImage = UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                self?.rootView.playPauseButton.setImage(buttonImage, for: .normal)
            }.store(in: &subscriptions)
        
        viewModel.$currentSongPlaybackTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentSongPlaybackTime in
                guard let self, !self.rootView.timelineSlider.isTracking else { return }
                self.rootView.timelineSlider.setValue(currentSongPlaybackTime, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.$ellapsedSongTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ellapsedSongTime in
                self?.rootView.elapsedTimeLabel.text = ellapsedSongTime
            }.store(in: &subscriptions)
        
        viewModel.$remainingSongTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] remainingSongTime in
                self?.rootView.remainingTimeLabel.text = remainingSongTime
            }.store(in: &subscriptions)
        
        viewModel.$totalSongTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] totalSongTime in
                self?.rootView.timelineSlider.maximumValue = totalSongTime
            }.store(in: &subscriptions)
    }
    
}

// MARK: @objc Methods
extension PlayerViewController {
    
    @objc func playbackSliderValueChanged(_ timelineSlider: UISlider) {
        viewModel.updateSongPlaybackTime(to: timelineSlider.value)
    }
    
    @objc private func toggleSongPlaybackState() {
        viewModel.toggleSongPlaybackState()
    }
    
}
