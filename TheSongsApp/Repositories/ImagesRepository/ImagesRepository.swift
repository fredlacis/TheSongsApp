//
//  ImageRepository.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

protocol ImagesRepository {
    
    typealias ImageCompletion = (Result<UIImage, Error>) -> Void
    
    func loadImage(from url: URL, completion: @escaping ImageCompletion)
    
}
