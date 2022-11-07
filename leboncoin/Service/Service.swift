//
//  Service.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    enum Response<T> {
        case results([T])
        case error(Error)
    }
    
    
    func getData<T: Decodable>(_ type : T, completion: @escaping ((Response<T>) -> Void)) {
        guard let url = Environment.urlType(type) else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {data, result, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Array<T>.self, from: data)
                completion(Response.results(results))
            } catch { completion(Response.error(error)) }
        }
        task.resume()
    }
}
