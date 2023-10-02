//
//  WebService.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

protocol WebService {
    
    func send<T: Decodable>(type: T.Type, _ endpoint: Endpoint, completionHandler: @escaping (Result<T, Error>) -> Void)
    
    func getImage(from url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void)
    
}
