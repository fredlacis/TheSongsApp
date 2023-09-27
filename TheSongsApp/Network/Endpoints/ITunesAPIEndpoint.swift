//
//  ITunesAPIEndpoint.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import Foundation

enum ITunesAPIEndpoint: Endpoint {
    case searchMusic(_ searchTerm: String, offset: Int = 0)
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "itunes.apple.com"
    }
    
    var path: String {
        switch self {
            case .searchMusic(_, _):
                return "search"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
            case .searchMusic(let searchTerm, let offset):
                return [
                    URLQueryItem(name: "media", value: "music"),
                    URLQueryItem(name: "limit", value: "15"),
                    URLQueryItem(name: "offset", value: "\(offset)"),
                    URLQueryItem(name: "term", value: searchTerm.replacingOccurrences(of: " ", with: "+"))
                ]
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var method: String {
        return "GET"
    }
}
