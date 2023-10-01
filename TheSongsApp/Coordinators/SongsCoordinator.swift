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
    
    let webService: WebService
    let imagesRepository: ImagesRepository
    let songsRepository: SongsRepository
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        webService = URLSessionWebService()
        imagesRepository = RemoteImagesRepository(webService: webService)
        songsRepository = ITunesAPISongsRepository(webService: webService)
    }
    
    func start() {
        let songSearchViewModel = SongSearchViewModel(songsRepository: songsRepository, imagesRepository: imagesRepository)
        let songSearchViewController = SongSearchViewController(viewModel: songSearchViewModel, coordinator: self)
        navigationController.setViewControllers([songSearchViewController], animated: true)
    }
    
    func selectSong(_ song: SongModel) {
        if let playerViewController = navigationController.viewControllers.first(where: { $0 is PlayerViewController }) as? PlayerViewController {
            playerViewController.viewModel.song = song
            navigationController.dismiss(animated: true)
            navigationController.popToViewController(playerViewController, animated: true)
        } else {
            let playerViewModel = PlayerViewModel(song: song, imagesRepository: imagesRepository)
            let playerViewController = PlayerViewController(viewModel: playerViewModel, coordinator: self)
            navigationController.pushViewController(playerViewController, animated: true)
        }
    }
    
    func displaySongOptions(_ song: SongModel) {
        let songOptionsViewModel = SongOptionsViewModel(song: song)
        let songOptionsViewController = SongOptionsViewController(viewModel: songOptionsViewModel, coordinator: self)
        let songOptionsViewNavigationController = UINavigationController(rootViewController: songOptionsViewController)
        navigationController.present(songOptionsViewNavigationController, animated: true)
    }
    
    func presentAlbumDetails(_ album: AlbumModel) {
        let albumSongsViewModel = AlbumSongsViewModel(album: album, songsRepository: songsRepository, imagesRepository: imagesRepository)
        let albumSongsViewController = AlbumSongsViewController(viewModel: albumSongsViewModel, coordinator: self)
        let albumSongsNavigationController = UINavigationController(rootViewController: albumSongsViewController)
        navigationController.dismiss(animated: true)
        navigationController.present(albumSongsNavigationController, animated: true)
    }
    
}
