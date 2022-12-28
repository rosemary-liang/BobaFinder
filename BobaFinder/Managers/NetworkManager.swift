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
    
    let cache = NSCache<NSString, UIImage>()
    let headers = [
      "accept": "application/json",
      "Authorization": "fsq3/vG10P9E7CJrfEW2r0kHgYFSzOyw0fl0ni5mKhnrx1Y="
    ]
    
    
    func getPlaces(for zipcode: String, completed: @escaping (Result<[Place], BFError>) -> Void) {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.foursquare.com"
//        components.path = "/v3/places/search"
//        components.queryItems = [
//            URLQueryItem(name: "query", value: "bubble tea shop"),
//            URLQueryItem(name: "near", value: zipcode)
//        ]
//
//        let url = components.url
//
//        guard let url = url else {
//            completed(.failure(.invalidZipcode))
//            return
//        }
//
//        // add params & headers
//        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
//
//
////        request.addValue("boba", forHTTPHeaderField: "query")
////        request.addValue("\(zipcode)", forHTTPHeaderField: "near")
//
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
//        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
//
//        }
//
//        task.resume()
        


        let request = NSMutableURLRequest(url: NSURL(string: baseURL + "?categories=13033&near=\(zipcode)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
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
        })

        task.resume()
    }
    
    
    func getPhotoURL(for fsqId: String, completed: @escaping (Result<[Photo], BFError>) -> Void) {
        // return either first photo or placeholder image


        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqId)/photos?limit=1&sort=POPULAR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
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
                let photo = try JSONDecoder().decode([Photo].self, from: jsonData!)
                completed(.success(photo))
            } catch {
                completed(.failure(.invalidData))
            }
            
//            self.cache.setObject(image, forKey: cacheKey)
//            completed(image)
        })
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
