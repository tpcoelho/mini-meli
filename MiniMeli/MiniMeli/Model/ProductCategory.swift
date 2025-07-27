//
//  ProductCategory.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import Foundation

struct ProductCategory: Codable {
    let id: String
    let name: String
    let pathFromRoot: [SubCategory]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pathFromRoot = "path_from_root"
    }
}

struct SubCategory: Codable {
    let id: String
    let name: String
}
