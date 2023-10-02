//
//  NetworkError.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 01/10/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidEndpoint
    case unableToComplete
    case badRequest
    case notFound
    case serverError
    case noData
    case unableToParse
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidEndpoint:
            return "Endpoint URL is invalid"
        case .unableToComplete:
            return "Could not complete operation"
        case .badRequest:
            return "Bad request"
        case .notFound:
            return "Not found"
        case .serverError:
            return "Internal server error"
        case .noData:
            return "No data on response"
        case .unableToParse:
            return "Unable to parse response data"
        default:
            return "Unknown error"
        }
    }
}
