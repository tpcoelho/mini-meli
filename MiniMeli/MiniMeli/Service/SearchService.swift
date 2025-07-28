//
//  SearchService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

class SearchService {
    let request: RequestProvider
    
    init(request: RequestProvider) {
        self.request = request
    }
    
    func search(query: String) async throws -> [Product] {
        let searchResponse: SearchResponse = try await request.fetch(endpoint: EndpointApi.search.rawValue, query: query.lowercased())
        return searchResponse.results
    }
}
