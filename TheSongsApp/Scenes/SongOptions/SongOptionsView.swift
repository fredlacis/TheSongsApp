//
//  SongOptionsView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import UIKit

class SongOptionsView: UIView {
    
    var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var subtitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    var openAlbumButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.configurationUpdateHandler = { button in
            var config = UIButton.Configuration.plain()
            config.title = "Open album"
            config.baseForegroundColor = .label
            config.image = UIImage(named: "albumIcon")?.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 16.0
            button.configuration = config
        }
        button.updateConfiguration()
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
        backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(openAlbumButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24.0),
            
            subtitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -8.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            openAlbumButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40.0),
            openAlbumButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -80.0),
            openAlbumButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            openAlbumButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
}
