//
//  LocalNetwork.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation
import UIKit

class LocalNetwork: RequestProvider {
    func fetch<T: Decodable>(endpoint: String, query: String) async throws -> T {
        guard let url = Bundle.main.url(forResource: getFileName(endpoint, query: query), withExtension: "json") else {
            throw NSError(domain: "LocalNetwork", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        do {
            let randomSeconds = Int.random(in: 2...6)
            try await Task.sleep(nanoseconds: UInt64(randomSeconds) * 1_000_000_000)
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            throw  NSError(domain: "LocalNetwork", code: 1, userInfo: [NSLocalizedDescriptionKey: "Json is not valid"])
        }
    }
    
    func fetchImage(url: URL) async throws -> Data? {
        guard let image = UIImage(named: "default_thumbnail") else {
            print("Imagem 'default_thumbnail' não encontrada nos Assets.")
            return nil
        }
        if let pngData = image.pngData() {
            return pngData
        }
        return image.jpegData(compressionQuality: 1.0)
    }
}
// MARK: - Helper

extension LocalNetwork {
    private func getFileName(_ endpoint: String, query: String) -> String {
        switch EndpointApi(rawValue: endpoint){
        case .search:
            return "search-MLA-\(query)"
        default:
            return ""
        }
    }
}
