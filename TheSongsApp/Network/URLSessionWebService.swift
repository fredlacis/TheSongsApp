//
//  URLSessionWebService.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import UIKit

final class URLSessionWebService: WebService {
    
    private let urlSession: URLSession = URLSession(configuration: .default)
    
    public func send<T: Decodable>(type: T.Type, _ endpoint: Endpoint, completionHandler: @escaping (Result<T, Error>) -> Void) {
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
    
    public func getImage(from url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
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
    
    private func parseJSON<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
}

