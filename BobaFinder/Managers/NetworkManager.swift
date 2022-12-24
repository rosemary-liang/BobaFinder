//
//  NetworkManager.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.foursquare.com/v3/places/"
    
    func getPlaces(for zipcode: String) async throws -> Place {
        let endpoint = baseURL + "search?query=\"bubble_tea_shop\"&near=\"\(zipcode)\""
        
    }
}
