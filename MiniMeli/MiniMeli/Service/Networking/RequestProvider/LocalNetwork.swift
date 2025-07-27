//
//  LocalNetwork.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation
import UIKit

class LocalNetwork: RequestProvider {
    private let useFakeLoading: Bool
    init(useFakeLoading: Bool = true) {
        self.useFakeLoading = useFakeLoading
    }
    func fetch<T: Decodable>(endpoint: String, query: String) async throws -> T {
        let fileName = getFileName(endpoint, query: query)
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "LocalNetwork", code: 1, userInfo: [NSLocalizedDescriptionKey: "File '\(fileName)' not found"])
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        do {
            if useFakeLoading {
                let randomSeconds = Int.random(in: 2...6)
                try await Task.sleep(nanoseconds: UInt64(randomSeconds) * 1_000_000_000)
            }
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            throw  NSError(domain: "LocalNetwork", code: 1, userInfo: [NSLocalizedDescriptionKey: "Json is not valid"])
        }
    }
    
    func fetchImage(url: URL) async throws -> Data? {
        guard let image = UIImage(named: "default_thumbnail2") else {
            print("Imagem 'default_thumbnail' não encontrada nos Assets.")
            return nil
        }
        if useFakeLoading {
            try await Task.sleep(nanoseconds: 2_000_000_000)
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
        case .categories:
            return "item-\(query)-category"
        case .description:
            return "item-\(query)-description"
        case .productDetails:
            return "item-\(query)"
        default:
            return ""
        }
    }
}
