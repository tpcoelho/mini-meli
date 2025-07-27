//
//  Double+currencyMask.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import Foundation

extension Double {
    func asCurrency(currencyCode: String? = nil, locale: Locale = Locale(identifier: "pt_BR")) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        if let code = currencyCode {
            formatter.currencyCode = code
            if let matchedLocale = Locale.availableIdentifiers
                .compactMap({ Locale(identifier: $0) })
                .first(where: { $0.currency?.identifier == code }) {
                formatter.locale = matchedLocale
            }
        }

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
