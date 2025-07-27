//
//  ItemDetailsViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

class ItemDetailsViewController: UIViewController {
    private let viewModel: ItemDetailsViewModelProtocol
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var mainView: ItemDetailsView = {
        let view = ItemDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: ItemDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewOutput = self
        viewModel.viewDidLoad()
    }
}

extension ItemDetailsViewController: ViewCodeConfiguration {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = Colors.Background.variant02
    }
}

extension ItemDetailsViewController: ItemDetailsViewModelOutput {
    func updateState(_ state: ItemDetailsState) {
        switch state {
        case .loading:
            LoadingHUD.shared.start()
        case .loaded:
            LoadingHUD.shared.stop()
            mainView.setupDetails(for: viewModel.product)
        }
    }
}
