//
//  RequestProvider.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

protocol RequestProvider: AnyObject {
    func fetch<T: Decodable>(endpoint: String, query: String) async throws -> T
}
