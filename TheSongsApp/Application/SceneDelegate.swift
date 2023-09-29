//
//  SceneDelegate.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 25/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var applicationCoordinator: CoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator?.start()
        window.makeKeyAndVisible()
    }

}
