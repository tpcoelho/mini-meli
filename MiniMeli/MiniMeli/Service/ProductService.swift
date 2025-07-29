//
//  ProductService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

protocol ProductServiceProtocol {
    func searchProducts(query: String) async throws -> [Product]
    func getProductDetails(productId: String) async throws -> ProductDetails
    func getCategory(product: Product) async throws -> ProductCategory
    func getDescription(productId: String) async throws -> ProductDescription
}

class ProductService: ProductServiceProtocol {
    let request: RequestProvider
    
    init(request: RequestProvider) {
        self.request = request
    }
    
    func searchProducts(query: String) async throws -> [Product] {
        let searchResponse: SearchResponse = try await request.make(requestobj: MiniMeliRequest.search(query: query))
        return searchResponse.results
    }
    
    func getProductDetails(productId: String) async throws -> ProductDetails {
        let productDetails: ProductDetails = try await  request.make(requestobj: MiniMeliRequest.productDetails(productId: productId))
        return productDetails
    }
    
    func getCategory(product: Product) async throws -> ProductCategory {
        let productCategory: ProductCategory = try await request.make(requestobj: MiniMeliRequest.categories(product: product))
        return productCategory
    }
    
    func getDescription(productId: String) async throws -> ProductDescription {
        let productDescription: ProductDescription = try await request.make(requestobj: MiniMeliRequest.description(productId: productId))
        return productDescription
    }
}
