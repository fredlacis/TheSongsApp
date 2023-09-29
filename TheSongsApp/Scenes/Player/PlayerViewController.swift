//
//  PlayerViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

class PlayerViewController: BaseViewController<PlayerView> {
    
    let viewModel: PlayerViewModel
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOptionsButton()
    }
    
    private func setupOptionsButton() {
        guard let ellipsisImage = UIImage(systemName: "ellipsis"),
              let ellipsisCGImage = ellipsisImage.cgImage else { return }
        let verticalEllipsisImage = UIImage(cgImage: ellipsisCGImage, scale: ellipsisImage.scale, orientation: .right)
            .withTintColor(.label)
            .withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: verticalEllipsisImage, style: .plain, target: nil, action: nil)
    }
    
}
