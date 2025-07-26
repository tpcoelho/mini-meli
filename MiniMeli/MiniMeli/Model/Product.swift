//
//  Product.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

struct Product: Decodable {
    let id: String
    let title: String
    let categoryId: String
    let thumbnail: String
    let currencyId: String
    let price: Double
    let availableQuantity: Int
    let seller: Seller

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case categoryId = "category_id"
        case thumbnail
        case currencyId = "currency_id"
        case price
        case availableQuantity = "available_quantity"
        case seller
    }
}

struct Seller: Decodable {
    let id: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
    }
}
