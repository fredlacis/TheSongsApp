//
//  PlayerView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

class PlayerView: UIView {
    
    var artworkContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "trackImagePlaceholder")
        return imageView
    }()
    
    var playerControllsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24.0)
        
        #warning("placeholder")
        label.text = "Something"
        
        return label
    }()
    
    var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .systemGray
        
        #warning("placeholder")
        label.text = "Artist"
        
        return label
    }()
    
    var timelineSlider: TSASlider = {
        let slider = TSASlider()
        slider.thumbTintColor = .label
        slider.minimumTrackTintColor = .label
        slider.maximumTrackTintColor = .systemGray
        return slider
    }()
    
    var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .systemGray
        
        #warning("placeholder")
        label.text = "0:00"
        
        return label
    }()
    
    var remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .systemGray
        
        #warning("placeholder")
        label.text = "-3:20"
        
        return label
    }()
    
    var playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .label
        return button
    }()
    
    var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .label
        return button
    }()
    
    var backwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(artworkContainerView)
        artworkContainerView.addSubview(artworkImageView)
        
        addSubview(playerControllsContainerView)
        playerControllsContainerView.addSubview(titleLabel)
        playerControllsContainerView.addSubview(artistLabel)
        playerControllsContainerView.addSubview(timelineSlider)
        playerControllsContainerView.addSubview(elapsedTimeLabel)
        playerControllsContainerView.addSubview(remainingTimeLabel)
        playerControllsContainerView.addSubview(playPauseButton)
        playerControllsContainerView.addSubview(forwardButton)
        playerControllsContainerView.addSubview(backwardButton)
    }
    
    func setupConstraints() {
        setupArtworkConstraints()
        setupPlayerControllConstraints()
    }
    
    private func setupArtworkConstraints() {
        NSLayoutConstraint.activate([
            artworkContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            artworkContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            artworkContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            artworkContainerView.bottomAnchor.constraint(equalTo: playerControllsContainerView.topAnchor),
            
            artworkImageView.centerYAnchor.constraint(equalTo: artworkContainerView.centerYAnchor),
            artworkImageView.centerXAnchor.constraint(equalTo: artworkContainerView.centerXAnchor),
            artworkImageView.widthAnchor.constraint(equalTo: artworkContainerView.widthAnchor, multiplier: 0.51),
            artworkImageView.heightAnchor.constraint(equalTo: artworkImageView.heightAnchor),
        ])
    }
    
    private func setupPlayerControllConstraints() {
        NSLayoutConstraint.activate([
            playerControllsContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            playerControllsContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            playerControllsContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: playerControllsContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: playerControllsContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playerControllsContainerView.trailingAnchor),
            
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: playerControllsContainerView.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: playerControllsContainerView.trailingAnchor),
            
            timelineSlider.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 16.0),
            timelineSlider.leadingAnchor.constraint(equalTo: playerControllsContainerView.leadingAnchor),
            timelineSlider.trailingAnchor.constraint(equalTo: playerControllsContainerView.trailingAnchor),
            
            elapsedTimeLabel.topAnchor.constraint(equalTo: timelineSlider.bottomAnchor, constant: 0.0),
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: playerControllsContainerView.leadingAnchor),
            
            remainingTimeLabel.topAnchor.constraint(equalTo: timelineSlider.bottomAnchor, constant: 0.0),
            remainingTimeLabel.trailingAnchor.constraint(equalTo: playerControllsContainerView.trailingAnchor),
            
            playPauseButton.topAnchor.constraint(equalTo: elapsedTimeLabel.bottomAnchor, constant: 16.0),
            playPauseButton.centerXAnchor.constraint(equalTo: playerControllsContainerView.centerXAnchor),
            playPauseButton.bottomAnchor.constraint(equalTo: playerControllsContainerView.bottomAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 68.0),
            playPauseButton.heightAnchor.constraint(equalTo: playPauseButton.widthAnchor),
            
            backwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            backwardButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -28.0),
            backwardButton.widthAnchor.constraint(equalTo: playPauseButton.widthAnchor, multiplier: 0.5),
            backwardButton.heightAnchor.constraint(equalTo: backwardButton.widthAnchor),
            
            forwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            forwardButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 28.0),
            forwardButton.widthAnchor.constraint(equalTo: playPauseButton.widthAnchor, multiplier: 0.5),
            forwardButton.heightAnchor.constraint(equalTo: forwardButton.widthAnchor),
        ])
    }
    
}
