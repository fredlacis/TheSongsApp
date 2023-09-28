//
//  DTOProtocol.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 27/09/23.
//

import Foundation

protocol DTOProtocol {    
    associatedtype Model
    
    func map() -> Model?
}
