//
//  ErrorType.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

enum ErrorType: String {
    case genericError
    case searchNotFound
    
    func getErrorObj() -> MiniMeliError {
        switch self {
        case .genericError:
            return MiniMeliError(image: "exclamationmark.triangle.fill",
                                 title: "Oops!",
                                 subtitle: "Something went wrong. Please try again later.")
        default:
            return MiniMeliError(image: "exclamationmark.triangle.fill",
                                 title: "Oops!",
                                 subtitle: "Something went wrong. Please try again later.")
        }
    }
}

struct MiniMeliError {
    let image: String
    let title: String
    let subtitle: String
}
