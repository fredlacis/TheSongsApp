//
//  MockSongsRepository.swift
//  TheSongsAppTests
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation
@testable import TheSongsApp

class MockSongsRepository: SongsRepository {
    
    var shouldReturnError = false
 
    func searchSongs(byTerm: String, page: Int, completion: @escaping SongsCompletion) {
        if shouldReturnError {
            completion(.failure(NetworkError.unknown))
            return
        }
        
        completion(.success([.mock1, .mock2]))
    }
    
    func getAlbumSongs(byID: Int, completion: @escaping SongsCompletion) {
        if shouldReturnError {
            completion(.failure(NetworkError.unknown))
            return
        }
        
        completion(.success([.mock1, .mock2]))
    }
    
}
