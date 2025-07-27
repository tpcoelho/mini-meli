//
//  ProductDescription.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import Foundation

struct ProductDescription: Codable {
    let text: String
    let plainText: String
    let lastUpdated: String
    let dateCreated: String

    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case lastUpdated = "last_updated"
        case dateCreated = "date_created"
    }
}
