//
//  MockProductService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation
@testable import MiniMeli

final class MockProductService: ProductServiceProtocol {
    var searchResult: [Product] = []
    var detailsResult: ProductDetails!
    var categoryResult: ProductCategory!
    var descriptionResult: ProductDescription!
    
    var shouldThrow = false

    private(set) var didCallSearch = false
    private(set) var didCallDetails = false
    private(set) var didCallCategory = false
    private(set) var didCallDescription = false

    func searchProducts(query: String) async throws -> [Product] {
        didCallSearch = true
        if shouldThrow { throw NSError(domain: "MockError", code: 0) }
        return searchResult
    }

    func getProductDetails(productId: String) async throws -> ProductDetails {
        didCallDetails = true
        if shouldThrow { throw NSError(domain: "MockError", code: 1) }
        return detailsResult
    }

    func getCategory(product: Product) async throws -> ProductCategory {
        didCallCategory = true
        if shouldThrow { throw NSError(domain: "MockError", code: 2) }
        return categoryResult
    }

    func getDescription(productId: String) async throws -> ProductDescription {
        didCallDescription = true
        if shouldThrow { throw NSError(domain: "MockError", code: 3) }
        return descriptionResult
    }
}
