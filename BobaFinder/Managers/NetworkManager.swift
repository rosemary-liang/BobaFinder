//
//  NetworkManager.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.foursquare.com/v3/places"
    
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    let headers = [
      "accept": "application/json",
      "Authorization": "fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
    ]
    
    
    func getPlaces(for zipcode: String) async throws -> [Place] {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "/search?categories=13033&near=\(zipcode)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BFError.invalidResponse
        }
        
        do {
            let root = try decoder.decode(Root.self, from: data)
            let places = root.results
            return places
        } catch {
            throw BFError.invalidData
        }
    }
    
    
    func getPhotoURLs(for fsqId: String) async throws -> [Photo] {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "/\(fsqId)/photos?sort=POPULAR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BFError.invalidResponse
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
            let (data, _) = try await URLSession.shared.data(from: url)
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
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            // Some valid Place fsqIds do not have any tips but return invalid response.
            // Did a second request to validate the Place fsqId.
            // If Place is valid, return empty Tips array rather than throw invalid response error.
            let requestValidatePlace = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            requestValidatePlace.httpMethod = "GET"
            requestValidatePlace.allHTTPHeaderFields = headers
            
            let (_, responseValidatePlace) = try await URLSession.shared.data(for: requestValidatePlace as URLRequest)
            guard let responseValidatePlace = responseValidatePlace as? HTTPURLResponse, responseValidatePlace.statusCode == 200 else {
                throw BFError.invalidResponse
            }
            
            return [] // return empty Tips array if place was validated
        }
        
        do {
            return try decoder.decode([Tip].self, from: data)
        } catch {
            throw BFError.invalidData
        }
    }

}
