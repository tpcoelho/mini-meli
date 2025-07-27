//
//  ProductDetails.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import Foundation

struct ProductDetails: Decodable {
    let id: String
    let title: String
    let currencyId: String
    let price: Double
    let condition: String
    let thumbnail: String
    let pictures: [ProductImage]
    let sellerAddress: SellerAddress
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case currencyId = "currency_id"
        case price
        case condition
        case thumbnail
        case pictures
        case sellerAddress = "seller_address"
    }
}

struct ProductImage: Codable {
    let id: String
    let url: String
    let secureUrl: String
    let size: String
    let maxSize: String
    let quality: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case secureUrl = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

struct SellerAddress: Codable {
    let id: Int
    let city: Location
    let state: Location
    let country: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case city
        case state
        case country
    }
}

struct Location: Codable {
    let id: String
    let name: String
}
