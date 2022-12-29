//
//  Tip.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

// MARK: - RootElement
struct Tip: Codable, Hashable {
    let id, createdAt, text: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case text
    }
}
