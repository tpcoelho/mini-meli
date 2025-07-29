//
//  Mock+Models.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation
@testable import MiniMeli


extension Product {
    static func mock() -> Product {
        return Product(
            id: "123",
            title: "Arroz Integral 5kg",
            categoryId: "MLA123",
            thumbnail: "http://image.url",
            currencyId: "BRL",
            price: 29.99,
            availableQuantity: 10,
            seller: Seller(id: 1, nickname: "Loja Teste")
        )
    }
}

extension ProductDetails {
    static func mock() -> ProductDetails {
        return ProductDetails(
            id: "MLA123456789",
            title: "Arroz Integral Premium 5kg",
            currencyId: "BRL",
            price: 32.90,
            condition: "new",
            thumbnail: "https://example.com/thumb.jpg",
            pictures: [
                ProductImage(
                    id: "1",
                    url: "https://example.com/img1.jpg",
                    secureUrl: "https://example.com/img1.jpg",
                    size: "500x500",
                    maxSize: "1000x1000",
                    quality: "high"
                ),
                ProductImage(
                    id: "2",
                    url: "https://example.com/img2.jpg",
                    secureUrl: "https://example.com/img2.jpg",
                    size: "600x600",
                    maxSize: "1200x1200",
                    quality: "high"
                )
            ],
            sellerAddress: SellerAddress(
                id: 987654,
                city: Location(id: "BR-FLN", name: "Florianópolis"),
                state: Location(id: "BR-SC", name: "Santa Catarina"),
                country: Location(id: "BR", name: "Brasil")
            ))
    }
}

extension ProductDescription {
    static func mock() -> ProductDescription {
        return ProductDescription(
            text: "Descrição completa do produto",
            plainText: "Texto simples",
            lastUpdated: "",
            dateCreated: ""
        )
    }
}
