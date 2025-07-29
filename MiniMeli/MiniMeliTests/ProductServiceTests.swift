//
//  ProductServiceTests.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import XCTest
@testable import MiniMeli

final class ProductServiceTests: XCTestCase {
    
    var service: ProductService!
    var mockRequest: MockRequestProvider!

    override func setUp() {
        super.setUp()
        mockRequest = MockRequestProvider()
        service = ProductService(request: mockRequest)
    }

    override func tearDown() {
        mockRequest = nil
        service = nil
        super.tearDown()
    }

    func test_searchProducts_success() async throws {
        mockRequest.mockResponse = SearchResponse(siteId: "MLA", countryDefaultTimeZone: "GMT-3", query: "arroz", results: [Product.mock()])
        
        let products = try await service.searchProducts(query: "arroz")
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.title, "Arroz Integral 5kg")
    }

    func test_getProductDetails_success() async throws {
        mockRequest.mockResponse = ProductDetails.mock()
        
        let details = try await service.getProductDetails(productId: "MLA123456789")
        XCTAssertEqual(details.id, "MLA123456789")
        XCTAssertEqual(details.title, "Arroz Integral Premium 5kg")
    }

    func test_getCategory_success() async throws {
        mockRequest.mockResponse = ProductCategory(id: "MLA123", name: "Arroz", pathFromRoot: [])
        
        let category = try await service.getCategory(product: Product.mock())
        XCTAssertEqual(category.id, "MLA123")
        XCTAssertEqual(category.name, "Arroz")
    }

    func test_getDescription_success() async throws {
        mockRequest.mockResponse = ProductDescription.mock()
        
        let description = try await service.getDescription(productId: "123")
        XCTAssertEqual(description.text, "Descrição completa do produto")
    }
}
