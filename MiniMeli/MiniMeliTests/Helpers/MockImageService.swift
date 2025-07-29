//
//  MockImageService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation
@testable import MiniMeli

final class MockImageService: ImageServiceProtocol {
    private(set) var receivedURLString: String?
    var dataToReturn: Data?
    var shouldThrowError = false

    func getImage(from urlString: String) async throws -> Data? {
        receivedURLString = urlString
        if shouldThrowError {
            throw NSError(domain: "MockImageServiceError", code: 1)
        }
        return dataToReturn
    }
}
