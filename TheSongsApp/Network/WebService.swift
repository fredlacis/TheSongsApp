//
//  WebService.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

class WebService {
    
    private let urlSession: URLSession = URLSession(configuration: .default)
    
    public func get<T: Codable>(type: T.Type, _ endpoint: Endpoint, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.urlComponents().url else {
            completionHandler(.failure(NetworkError.invalidEndpoint))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               let error = self.checkStatus(response.statusCode) {
                completionHandler(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse: T = try self.parseJSON(data: data)
                    completionHandler(.success(decodedResponse))
                    return
                } catch {
                    completionHandler(.failure(NetworkError.unableToParse))
                    return
                }
            }
            
            completionHandler(.failure(NetworkError.noData))
        }
        
        task.resume()
    }
    
    public func getImage(from url: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(NetworkError.badRequest))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completionHandler(.success(image))
                return
            }
            
            completionHandler(.failure(NetworkError.unknown))
        }
            
        task.resume()
    }
    
    private func checkStatus(_ status: Int) -> NetworkError? {
        switch status {
            case 200...399:
                return nil
            case 400...499:
                return .badRequest
            case 404:
                return .notFound
            case 500...599:
                return .serverError
            default:
                return .unknown
        }
    }
    
    private func parseJSON<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
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
    
}

