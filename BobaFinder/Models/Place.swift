//
//  Place.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import Foundation

struct PlaceRoot: Codable {
    let results: [Place]
    let context: String
}

struct Place: Codable {
    let distance: Int
    let name: String
}







