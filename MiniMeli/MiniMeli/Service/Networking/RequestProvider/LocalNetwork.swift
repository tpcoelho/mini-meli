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
    func make<T: Decodable>(requestobj: RequestObj) async throws -> T {
        let fileName = getFileName(requestobj)
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            if requestobj.identifier == "search" {
                return SearchResponse(siteId: .empty, countryDefaultTimeZone: .empty, query: .empty, results: []) as! T
            }
            throw NSError(domain: "LocalNetwork", code: 2, userInfo: [NSLocalizedDescriptionKey: "File '\(fileName)' not found"])
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
    private func getFileName(_ requestobj: RequestObj) -> String {
        let itemid = requestobj.additionalInfo ?? .empty
        switch requestobj.identifier {
        case "search":
            return "search-MLA-\(itemid)"
        case "categories":
            return "item-\(itemid)-category"
        case "description":
            return "item-\(itemid)-description"
        case "productDetails":
            return "item-\(itemid)"
        default:
            return .empty
        }
    }
}
