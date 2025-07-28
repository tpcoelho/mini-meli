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
        viewModel.viewOutput = self
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
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Space.s40)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = Colors.Background.base
    }
}

extension SearchViewController: SearchViewDelegate {
    func textFieldShouldReturn(_ text: String?) {
        viewModel.search(text)
    }
}

extension SearchViewController: SearchViewModelOutput {
    func updateState(_ state: SearchState) {
        switch state {
        case .loading:
            LoadingHUD.shared.start()
        case .loaded(let searchResult):
            LoadingHUD.shared.stop()
            viewModel.coordinator.route(.searchResult(searchResult))
        case .error:
            LoadingHUD.shared.stop()
            viewModel.coordinator.route(.error(.genericError))
        }
    }
}
