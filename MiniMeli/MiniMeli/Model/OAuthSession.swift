//
//  OAuthSession.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import Foundation

class OAuthSession {
   
   static let shared = OAuthSession()
   
   private let tokenKey = "com.minimeli.token"
   
   private var token: OAuthResponse?
   
   var accessToken: String? {
       token?.accessToken
   }
   
   var isAuthenticated: Bool {
       accessToken != nil
   }
   
   private init() {
       loadToken()
   }
   
   func store(token response: OAuthResponse) {
       self.token = response
       saveTokenToUserDefaults(response)
       print("🔐 Token armazenado: \(response.accessToken.prefix(10))... (expira em \(response.expiresIn)s)")
   }
   
   func clear() {
       self.token = nil
       UserDefaults.standard.removeObject(forKey: tokenKey)
       print("🚫 Token removido")
   }
   
   func currentToken() -> OAuthResponse? {
       return token
   }
   
   // MARK: - Persistence
   
   private func saveTokenToUserDefaults(_ token: OAuthResponse) {
       do {
           let data = try JSONEncoder().encode(token)
           UserDefaults.standard.set(data, forKey: tokenKey)
       } catch {
           print("❌ Falha ao salvar token: \(error)")
       }
   }
   
   private func loadToken() {
       guard let data = UserDefaults.standard.data(forKey: tokenKey) else { return }
       
       do {
           let decoded = try JSONDecoder().decode(OAuthResponse.self, from: data)
           self.token = decoded
           print("🔁 Token carregado do UserDefaults.")
       } catch {
           print("❌ Falha ao carregar token: \(error)")
       }
   }
}

struct OAuthResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String?
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case userId = "user_id"
    }
}
