//
//  ErrorViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import UIKit

class ErrorViewController: UIViewController {
    private lazy var mainView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(error: MiniMeliError) {
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigationBar()
        mainView.setupError(image: error.image, title: error.title, description: error.subtitle)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorViewController: ViewCodeConfiguration {
    func buildViewHierarchy() {
        view.addSubview(mainView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
