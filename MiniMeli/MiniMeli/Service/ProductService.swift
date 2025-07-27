//
//  ProductService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

class ProductService {
    let request: RequestProvider
    
    init(request: RequestProvider) {
        self.request = request
    }
    
    func searchProducts(query: String) async throws -> [Product] {
        let searchResponse: SearchResponse = try await request.fetch(endpoint: EndpointApi.search.rawValue, query: query.lowercased())
        return searchResponse.results
    }
    
    func getProductDetails(productId: String) async throws -> ProductDetails {
        let productDetails: ProductDetails = try await request.fetch(endpoint: EndpointApi.productDetails.rawValue, query: productId)
        return productDetails
    }
    
    func getCategory(productId: String) async throws -> ProductCategory {
        let productCategory: ProductCategory = try await request.fetch(endpoint: EndpointApi.categories.rawValue, query: productId)
        return productCategory
    }
    
    func getDescription(productId: String) async throws -> ProductDescription {
        let productDescription: ProductDescription = try await request.fetch(endpoint: EndpointApi.description.rawValue, query: productId)
        return productDescription
    }
}
