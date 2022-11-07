//
//  Environnement.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation

enum Server {
    case developement
}

class Environment {
    
    static let server:Server = .developement
    
    class func APIBasePath() -> String {
        switch self.server {
        case .developement:
            return "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
        }
    }
    
    static func urlType<T>(_ type: T) -> URL? {
        let baseURL:String = {
            return Environment.APIBasePath()
        }()
        
        let relativePath: String? = {
            switch type {
            case is Item:
                return "listing.json"
            case is Category:
                return "categories.json"
            default:
                return "listing.json"
            }
        }()
        
        if let url = URL(string: baseURL) {
            if let relativePath = relativePath {
                return url.appendingPathComponent(relativePath)
            }
        }
        return nil
    }
    
}
