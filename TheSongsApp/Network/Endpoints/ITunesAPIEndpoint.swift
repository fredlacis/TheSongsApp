//
//  ITunesAPIEndpoint.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 26/09/23.
//

import Foundation

enum ITunesAPIEndpoint: Endpoint {
    case searchMusic(_ searchTerm: String, limit: Int, offset: Int = 0)
    case lookupAlbum(_ albumID: Int)
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "itunes.apple.com"
    }
    
    var path: String {
        switch self {
            case .searchMusic(_, _, _):
                return "/search"
            case .lookupAlbum(_):
                return "/lookup"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
            case .searchMusic(let searchTerm, let limit, let offset):
                return [
                    URLQueryItem(name: "media", value: "music"),
                    URLQueryItem(name: "limit", value: "\(limit)"),
                    URLQueryItem(name: "offset", value: "\(offset)"),
                    URLQueryItem(name: "term", value: searchTerm.replacingOccurrences(of: " ", with: "+")),
                ]
            case .lookupAlbum(let albumID):
                return [
                    URLQueryItem(name: "id", value: "\(albumID)"),
                    URLQueryItem(name: "entity", value: "song"),
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
