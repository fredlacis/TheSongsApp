//
//  UIScrollView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import UIKit

extension UIScrollView {
    
    var isBoucingOnBottom: Bool {
        contentOffset.y >= contentSize.height - bounds.height
    }
    
}
