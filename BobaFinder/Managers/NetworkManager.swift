//
//  NetworkManager.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.foursquare.com/v3/places/search"
    let apiKey = "fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
    
//    let decoder = JSONDecoder()
    
    
    func getPlaces(for zipcode: String, completed: @escaping (Result<[Place], BFError>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.foursquare.com"
        components.path = "/v3/places/search"
        components.queryItems = [
            URLQueryItem(name: "query", value: "bubble tea shop"),
            URLQueryItem(name: "near", value: zipcode)
        ]
        
        let url = components.url
        
        guard let url = url else {
            completed(.failure(.invalidZipcode))
            return
        }
        
        // add params & headers
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        
//        request.addValue("boba", forHTTPHeaderField: "query")
//        request.addValue("\(zipcode)", forHTTPHeaderField: "near")

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            
            do {
                let dataString = String(data: data, encoding: .utf8)
                let jsonData = dataString?.data(using: .utf8)
                let root = try JSONDecoder().decode(Root.self, from: jsonData!)
                let places = root.results
                completed(.success(places))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            #warning("reminder to add other error codes for more specific errors")
//            print(response)
//            throw BFError.invalidResponse
//        }
//
//        do {
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode([Place].self, from: data)
//
//        } catch {
//            throw BFError.invalidData
//        }
    }
}