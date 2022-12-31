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
    
//    func getPlaces(for zipcode: String, completed: @escaping (Result<[Place], BFError>) -> Void) {
//
//        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "?categories=13033&near=\(zipcode)")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest,
//                                        completionHandler: { (data, response, error) -> Void in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//
//            do {
//                let dataString = String(data: data, encoding: .utf8)
//                let jsonData = dataString?.data(using: .utf8)
//                let root = try JSONDecoder().decode(Root.self, from: jsonData!)
//                let places = root.results
//                completed(.success(places))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        })
//
//        task.resume()
//    }
    
    
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
    
//    func getPhotoURLs(for fsqId: String, completed: @escaping (Result<[Photo], BFError>) -> Void) {
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)/photos?sort=POPULAR")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest,
//                                        completionHandler: { (data, response, error) -> Void in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//
//            do {
//                let dataString = String(data: data, encoding: .utf8)
//                let jsonData = dataString?.data(using: .utf8)
//                let photos = try JSONDecoder().decode([Photo].self, from: jsonData!)
//                completed(.success(photos))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        })
//        task.resume()
//    }
    
    
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
    
    
//    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
//        let cacheKey = NSString(string: urlString)
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//            return
//        }
//
//        guard let url = URL(string: urlString) else {
//            completed(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self,
//                  error == nil,
//                  let response = response as? HTTPURLResponse, response.statusCode == 200,
//                  let data = data,
//                  let image = UIImage(data: data) else {
//                completed(nil)
//                return
//            }
//            self.cache.setObject(image, forKey: cacheKey)
//            completed(image)
//        }
//        task.resume()
//    }
    
    
    func getPlaceTips(for fsqId: String) async throws -> [Tip] {
        let headers = [
          "accept": "application/json",
          "Authorization": " fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)/tips?sort=POPULAR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BFError.invalidResponse
        }
        
        do {
            return try decoder.decode([Tip].self, from: data)
        } catch {
            throw BFError.invalidData
        }

    }
    
    
//    func getPlaceTips(for fsqId: String, completed: @escaping (Result<[Tip], BFError>) -> Void) {
//        let headers = [
//          "accept": "application/json",
//          "Authorization": " fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)/tips?sort=POPULAR")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
////        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)/tips?limit=2&sort=POPULAR")! as URL,
////                                                cachePolicy: .useProtocolCachePolicy,
////                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//
//            do {
//                let dataString = String(data: data, encoding: .utf8)
//                let jsonData = dataString?.data(using: .utf8)
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let tips = try decoder.decode([Tip].self, from: jsonData!)
//                completed(.success(tips))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        })
//
//        task.resume()
//    }
}
