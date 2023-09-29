//
//  UINavigationController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import UIKit

extension UINavigationController {
    
    func setupBackButton() {
        let backImage = UIImage(systemName: "arrow.left")?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
}
