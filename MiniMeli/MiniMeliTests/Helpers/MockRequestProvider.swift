//
//  MockRequestProvider.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation
@testable import MiniMeli

final class MockRequestProvider: RequestProvider {
    
    var mockResponse: Any?
    var mockImageData: Data?

    func make<T: Decodable>(requestobj: RequestObj) async throws -> T {
        guard let response = mockResponse as? T else {
            throw URLError(.badServerResponse)
        }
        return response
    }

    func fetchImage(url: URL) async throws -> Data? {
        return mockImageData
    }
}
