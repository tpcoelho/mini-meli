//
//  PreLoginViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

class PreLoginViewController: UIViewController {
    
    private lazy var mainView: PreLoginView = {
        let view = PreLoginView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PreLoginViewController: ViewCodeConfiguration {
    func buildViewHierarchy() {
        view.addSubview(mainView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func configureViews() {
        setupNavigationBar()
    }
}

extension PreLoginViewController: PreLoginViewDelegate {
    func startWithAPI() {
        guard let navController = navigationController else {
            fatalError("NavigationController is not available!!!")
        }
        MiniMeliCoordinator(navController).start()
    }
    
    func startWithMock() {
        guard let navController = navigationController else {
            fatalError("NavigationController is not available!!!")
        }
        MiniMeliCoordinator(navController).startMock()
    }
}
