//
//  SongsCoordinator.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

class SongsCoordinator: CoordinatorProtocol {
    
    var subCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let entryPoint = SongSearchViewController()
        entryPoint.coordinator = self
        navigationController.setViewControllers([entryPoint], animated: true)
    }
    
    func selectSong(_ song: SongModel) {
        let playerViewModel = PlayerViewModel(song: song)
        let playerView = PlayerViewController(viewModel: playerViewModel)
        navigationController.pushViewController(playerView, animated: true)
    }
    
}
