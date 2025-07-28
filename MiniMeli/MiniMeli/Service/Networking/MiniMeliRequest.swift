//
//  EndpointApi.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

struct MeliAPI {
    static let baseUrl: String = "https://api.mercadolibre.com"
    //let urlString = "https://api.mercadolibre.com/items/MLA1781975648" // erro 403
    //let urlString = "https://api.mercadolibre.com/products/search?status=active&site_id=MLA&q=arroz" 403
}

struct MiniMeliAPI {
    static let urlAuth = "https://auth.mercadolivre.com.br/authorization?response_type=code&client_id=\(clientId)&redirect_uri=\(redirectURI)"
    static let clientId = "7189118502852829"
    static let clientSecret = "3JHZdDDhD1G9gVE97cy8LxtXGy0IwrXf"
    static let redirectURI = "https://minimeli://token"
}

enum HTTPMethod: String {
    case POST
    case GET
}

protocol RequestObj {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]?  { get }
    var requiresAuth: Bool { get }
    var additionalInfo: String? { get }
    var identifier: String { get }
    
}
enum MiniMeliRequest: RequestObj {
    case search(query: String)
    case categories(product: Product)
    case description(productId: String)
    case productDetails(productId: String)
    case authToken(code: String)
    
    var endpoint: String {
        switch self {
        case .search(let query):
            return "\(MeliAPI.baseUrl)/sites/MLB/search?q=\(query)"
        case .categories(let product):
            return "\(MeliAPI.baseUrl)/categories/\(product.categoryId)"
        case .description(let itemId):
            return "\(MeliAPI.baseUrl)/items/\(itemId)/description"
        case .productDetails(let itemId):
            return "\(MeliAPI.baseUrl)/items/\(itemId)"
        case .authToken:
            return "\(MeliAPI.baseUrl)/oauth/token"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .categories, .productDetails, .description:
            return .GET
        case .authToken:
            return .POST
        }
    }
    
    var headers: [String: String]? {
        var defaultHeaders: [String: String] = [:]
        switch self {
        case .authToken:
            defaultHeaders["Content-Type"] = "application/x-www-form-urlencoded"
            defaultHeaders["Accept"] = "application/json"
        default:
            defaultHeaders["Accept"] = "application/json"
        }
        return defaultHeaders
    }
    
    var body: [String: String]? {
        switch self {
        case .authToken(let code):
            return ["grant_type": "authorization_code",
                    "client_id": MiniMeliAPI.clientId,
                    "client_secret": MiniMeliAPI.clientSecret,
                    "code": code,
                    "redirect_uri": MiniMeliAPI.redirectURI]
        default:
            return nil
        }
    }
    
    var requiresAuth: Bool {
        switch self {
        case .authToken:
            return false
        default:
            return true
        }
    }
    
    var identifier: String {
        switch self {
        case .search:
            return "search"
        case .categories:
            return "categories"
        case .description:
            return "description"
        case .productDetails:
            return "productDetails"
        case .authToken:
            return "authToken"
        }
    }
    
    var additionalInfo: String? {
        switch self {
        case .search(let query):
            return query
        case .categories(let product):
            return product.id
        case .description(let itemId):
            return itemId
        case .productDetails(let itemId):
            return itemId
        case .authToken:
            return nil
        }
    }
}
