//
//  NetworkManager.swift
//  BobaFinder
//
//  Created by Rosemary Liang on 12/23/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.foursquare.com/v3/places"
    
    private let cache = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()
    private let headers = [
      "accept": "application/json",
      "Authorization": "fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
    ]
    
    func getPlaces(for zipcode: String) async throws -> [Place] {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "/search?categories=13033&near=\(zipcode)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod          = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response)        = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BFError.invalidResponse
        }
        
        do {
            let root    = try decoder.decode(Root.self, from: data)
            let places  = root.results
            return places
        } catch {
            throw BFError.invalidData
        }
    }
    
    func getPhotoURLs(for fsqId: String) async throws -> [Photo] {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "/\(fsqId)/photos?sort=POPULAR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod          = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response)        = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response          = response as? HTTPURLResponse, response.statusCode == 200 else {
            // Some valid fsqId's return invalid getPhotoURLs response instead of empty array.
            // Manually return empty [Photo] array.
            return []
        }
        
        do {
            return try decoder.decode([Photo].self, from: data)
        } catch {
            throw BFError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _)   = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
            
        } catch {
            return nil
        }
    }
    
    func getPlaceTips(for fsqId: String) async throws -> [Tip] {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL +
                                                    "/\(fsqId)/tips?sort=POPULAR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod          = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response)        = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response          = response as? HTTPURLResponse, response.statusCode == 200 else {
            // Some valid Place fsqIds return invalid response instead of empty array.
            // Manually return empty [Tip] array rather than throw invalid response error.
            return []
        }
        
        do {
            return try decoder.decode([Tip].self, from: data)
        } catch {
            throw BFError.invalidData
        }
    }

}
