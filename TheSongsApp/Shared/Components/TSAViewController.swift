//
//  TSAViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

class TSAViewController<ViewClass: UIView>: UIViewController {
    
    var rootView: ViewClass { view as? ViewClass ?? ViewClass() }
    
    override func loadView() {
        view = ViewClass()
    }
    
}
