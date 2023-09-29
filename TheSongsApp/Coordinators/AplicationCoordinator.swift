//
//  AplicationCoordinator.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

class ApplicationCoordinator: NSObject, CoordinatorProtocol {

    var subCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController = UINavigationController()
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        navigationController.delegate = self
    }
    
    func start() {
        window.rootViewController = navigationController
        navigationController.setupBackButton()
        let songsCoordinator = SongsCoordinator(navigationController: navigationController)
        subCoordinators = [songsCoordinator]
        songsCoordinator.start()
    }

}

extension ApplicationCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonDisplayMode = .minimal
    }
    
}
