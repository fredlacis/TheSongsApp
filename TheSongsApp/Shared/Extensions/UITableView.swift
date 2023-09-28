//
//  UITableView.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: ReusableCellProtocol.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: ReusableCellProtocol>(ofType cellClass: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: cellClass.reusableIdentifier, for: indexPath) as? T
    }
    
}
