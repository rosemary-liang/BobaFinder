//
//  Photo.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import Foundation

struct Photo: Codable {
    let id, createdAt: String
    let rootPrefix: String
    let suffix: String
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case rootPrefix = "prefix"
        case suffix, width, height
    }
}
