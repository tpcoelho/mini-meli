//
//  ViewCodeConfiguration.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import Foundation

protocol ViewCodeConfiguration {
    func setupView()
    func buildViewHierarchy()
    func setupConstraints()
    /// *Optional* method Method shoudl be use to do extra configuration on the views. Like set background color, hidden views, etc
    func configureViews()
}

extension ViewCodeConfiguration {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {
        // optional function
    }
}
