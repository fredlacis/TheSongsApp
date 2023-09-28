//
//  RemoteImagesRepository.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 28/09/23.
//

import UIKit

final class RemoteImagesRepository: ImagesRepository {
    
    private let webService = WebService()
    
    private static var imagesCache = NSCache<NSString, UIImage>()

    func loadImage(from url: String, completion: @escaping ImageCompletion) {
        if let cachedImage = Self.imagesCache.object(forKey: url as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        webService.getImage(from: url) { result in
            switch result {
                case .success(let image):
                    completion(.success(image))
                    Self.imagesCache.setObject(image, forKey: url as NSString)
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

}
