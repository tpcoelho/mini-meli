//
//  MockSearchService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation
@testable import MiniMeli

final class MockSearchService: SearchServiceProtocol {
    private(set) var receivedQuery: String?
    var resultToReturn: [Product] = []
    var shouldThrowError = false

    func search(query: String) async throws -> [Product] {
        receivedQuery = query
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1)
        }
        return resultToReturn
    }
}
