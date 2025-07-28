//
//  SearchResponse.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

struct SearchResponse: Decodable {
    let siteId: String?
    let countryDefaultTimeZone: String?
    let query: String?
    let results: [Product]

    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query
        case results
    }
}
