//
//  UIColor+CustomColor.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct Colors {
    struct Action {
        static var primary = UIColor(hex: "#002B5B")             // Azul principal ML
        static var primaryVariant = UIColor(hex: "#336B9A")      // Azul médio mais claro
        static var secondary = UIColor(hex: "#FFEB3B")           // Amarelo mais forte (ainda legível)
        static var secondaryVariant = UIColor(hex: "#FFF176")    // Amarelo claro
        static var disabled = UIColor(hex: "#CFD1D3")
        static var disabledVariant = UIColor(hex: "#5F6D66")
    }
    
    struct Text {
        static var heading01 = UIColor(hex: "#002B5B")
        static var heading02 = UIColor(hex: "#00468C")
        static var text = UIColor(hex: "#0E2325")
        static var body01 = UIColor(hex: "#0E2325")
        static var body02 = UIColor(hex: "#1B464B")
        static var highlight = UIColor(hex: "#FFF176")           // Amarelo claro
        static var link = UIColor(hex: "#002B5B")
        static var linkVariant = UIColor(hex: "#00468C")
    }
    
    struct Background {
        static var base = UIColor(hex: "#FFFDE7")                // Amarelo muito claro
        static var variant01 = UIColor(hex: "#F2D06B")           // Bem suave
        static var variant02 = UIColor(hex: "#E3F2FD")
    }
    
    struct Border {
        static var soft = UIColor(hex: "#CFD1D3")
        static var medium = UIColor(hex: "#5F6D66")
        static var strong = UIColor(hex: "#002B5B")
    }
    
    struct Feedback {
        static var information = UIColor(hex: "#002B5B")
        static var informationContrast = UIColor(hex: "#FFFFFF")
        static var success = UIColor(hex: "#0B5B38")
        static var successContrast = UIColor(hex: "#FFFFFF")
        static var error = UIColor(hex: "#CC0000")
        static var errorContrast = UIColor(hex: "#FFFFFF")
        static var alert = UIColor(hex: "#FFD54F")               // Amarelo alaranjado claro
        static var alertContrast = UIColor(hex: "#000000")       // Texto preto p/ contraste
        static var neutral = UIColor(hex: "#1B464B")
        static var neutralContrast = UIColor(hex: "#FFFFFF")
    }
    struct Contrast {
        static var black = UIColor(hex: "#000000")
        static var white = UIColor(hex: "#FFFFFF")
    }
}
