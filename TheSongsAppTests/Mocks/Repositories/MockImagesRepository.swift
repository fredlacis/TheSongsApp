//
//  MockImagesRepository.swift
//  TheSongsAppTests
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import UIKit
@testable import TheSongsApp

final class MockImagesRepository: ImagesRepository {
    
    var shouldReturnError = false

    func loadImage(from url: URL, completion: @escaping ImageCompletion) {
        if shouldReturnError {
            completion(.failure(NetworkError.unknown))
            return
        }
        
        completion(.success(UIImage(systemName: "music.note")!))
    }

}
