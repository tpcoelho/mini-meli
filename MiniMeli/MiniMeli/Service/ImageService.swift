//
//  ImageService.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//

import Foundation

class ImageService {
    let request: RequestProvider
    
    init(request: RequestProvider) {
        self.request = request
    }
    
    func getItmage(from urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        return try await request.fetchImage(url: url)
    }
}
