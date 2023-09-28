//
//  WebServiceInjection.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import Foundation

protocol WebServiceInjection {
    var webService: WebServiceProtocol { get }
}

extension WebServiceInjection {
    var webService: WebServiceProtocol {
        return WebService()
    }
}
