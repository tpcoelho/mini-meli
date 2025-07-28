//
//  APINetwork.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//


import Foundation
import UIKit

class APINetwork: RequestProvider {
    func make<T: Decodable>(requestobj: RequestObj) async throws -> T {
        guard let url = URL(string: requestobj.endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestobj.method.rawValue
        // Headers
        requestobj.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        // Auth
        if requestobj.requiresAuth {
            guard let token = OAuthSession.shared.accessToken else {
                throw URLError(.userAuthenticationRequired)
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        // Body
        if let bodyDict = requestobj.body {
            let bodyString = bodyDict.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            }.joined(separator: "&")
            request.httpBody = bodyString.data(using: .utf8)
        }
        
        print(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        
#if DEBUG
        if let json = String(data: data, encoding: .utf8) {
            print("📦 JSON Response: \(json)")
        }
#endif
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // necessário para os campos Date
        return try decoder.decode(T.self, from: data)
    }

    func requestOAuthToken(code: String) async throws -> OAuthResponse {
        return try await make(requestobj: MiniMeliRequest.authToken(code: code))
    }
    
    func fetchImage(url: URL) async throws -> Data? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                return nil
            }
            return data
        } catch {
            print("Erro ao baixar imagem: \(error)")
            return nil
        }
    }
}
