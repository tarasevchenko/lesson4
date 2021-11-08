//
//  NetworkService.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init () {}
    
    func getCatsData(url: URL, completion: @escaping ([Fact]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let facts = try JSONDecoder().decode([Fact].self, from: data!)
                completion(facts)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

