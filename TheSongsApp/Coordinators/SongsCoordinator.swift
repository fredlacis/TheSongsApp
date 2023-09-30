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
        if let playerViewController = navigationController.viewControllers.first(where: { $0 is PlayerViewController }) as? PlayerViewController {
            playerViewController.viewModel.song = song
            navigationController.dismiss(animated: true)
            navigationController.popToViewController(playerViewController, animated: true)
        } else {
            let playerViewModel = PlayerViewModel(song: song)
            let playerViewController = PlayerViewController(viewModel: playerViewModel)
            playerViewController.coordinator = self
            navigationController.pushViewController(playerViewController, animated: true)
        }
    }
    
    func displaySongOptions(_ song: SongModel) {
        let songOptionsViewModel = SongOptionsViewModel(song: song)
        let songOptionsViewController = SongOptionsViewController(viewModel: songOptionsViewModel)
        songOptionsViewController.coordinator = self
        navigationController.present(songOptionsViewController, animated: true)
    }
    
    func presentAlbumDetails(_ album: AlbumModel) {
        let albumSongsViewModel = AlbumSongsViewModel(album: album)
        let albumSongsViewController = AlbumSongsViewController(viewModel: albumSongsViewModel)
        let albumSongsNavigationController = UINavigationController(rootViewController: albumSongsViewController)
        albumSongsViewController.coordinator = self
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.present(albumSongsNavigationController, animated: true)
        }
    }
    
}
