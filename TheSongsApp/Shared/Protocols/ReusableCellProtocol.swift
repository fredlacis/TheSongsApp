//
//  ReusableIdentifierProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Foundation

protocol ReusableCellProtocol: AnyObject {
    static var reusableIdentifier: String { get }
}

extension ReusableCellProtocol {
    static var reusableIdentifier: String {
        return String(describing: Self.self)
    }
}
