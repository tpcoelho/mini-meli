//
//  LoadingHUD.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import UIKit

final class LoadingHUD {
    static let shared = LoadingHUD()
    private var hudView: UIView?
    
    private init() {}
    
    private var keyWindow: UIWindow? {
        // Busca a window ativa de qualquer UIWindowScene conectada
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    func start() {
        guard hudView == nil, let window = keyWindow else { return }
        
        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor(white: 0, alpha: 0.3)
        overlay.isUserInteractionEnabled = true
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        container.layer.cornerRadius = Space.s16
        overlay.addSubview(container)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        container.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 80),
            container.heightAnchor.constraint(equalToConstant: 80),
            
            spinner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        window.addSubview(overlay)
        hudView = overlay
    }
    
    func stop() {
        hudView?.removeFromSuperview()
        hudView = nil
    }
}
