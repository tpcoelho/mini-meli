//
//  SearchViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//


import UIKit

class SearchViewController: UIViewController {
    private lazy var mainView: SearchView = {
        let view = SearchView(viewDelegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let viewModel: SearchViewModelProtocol
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigationBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchViewController: ViewCodeConfiguration {
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
}

extension SearchViewController: SearchViewDelegate {
    func textFieldShouldReturn(_ text: String?) {
        viewModel.search(text)
    }
}
