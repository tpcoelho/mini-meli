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
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
//                return nil
//            }
//            return data
//        } catch {
//            print("Erro ao baixar imagem: \(error)")
//            return nil
//        }
    }
}
