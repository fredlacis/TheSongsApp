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
        let songSearchViewController = SongSearchViewController()
        songSearchViewController.coordinator = self
        navigationController.setViewControllers([songSearchViewController], animated: true)
    }
    
    func selectSong(_ song: SongModel) {
        let playerViewModel = PlayerViewModel(song: song)
        let playerViewController = PlayerViewController(viewModel: playerViewModel)
        playerViewController.coordinator = self
        navigationController.pushViewController(playerViewController, animated: true)
    }
    
    func displaySongOptions(_ song: SongModel) {
        let songOptionsViewModel = SongOptionsViewModel(song: song)
        let songOptionsViewController = SongOptionsViewController(viewModel: songOptionsViewModel)
        navigationController.present(songOptionsViewController, animated: true)
    }
    
}
