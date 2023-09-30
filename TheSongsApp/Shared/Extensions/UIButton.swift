//
//  UIButton.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import UIKit

extension UIButton {
    
    func setImageWithTransition(_ image: UIImage?, for state: UIControl.State, duration: TimeInterval = 0.15) {
        UIView.transition(with: self,
                          duration: duration,
                          options: [.transitionCrossDissolve, .curveEaseInOut],
                          animations: { [weak self] in
                              self?.setImage(image, for: state)
                          })
    }
    
}
