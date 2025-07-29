//
//  SearchService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

protocol SearchServiceProtocol {
    func search(query: String) async throws -> [Product]
}

class SearchService: SearchServiceProtocol {
    let request: RequestProvider
    
    init(request: RequestProvider) {
        self.request = request
    }
    
    func search(query: String) async throws -> [Product] {
        let searchResponse: SearchResponse = try await request.make(requestobj: MiniMeliRequest.search(query: query.lowercased()))
        return searchResponse.results
    }
}
