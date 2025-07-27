//
//  RequestProvider.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation
protocol RequestProvider: AnyObject {
    func fetch<T: Decodable>(endpoint: String, query: String) async throws -> T
    func fetchImage(url: URL) async throws -> Data?
}
