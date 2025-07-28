//
//  ProductDetailsViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

class ProductDetailsViewController: UIViewController {
    private let viewModel: ProductDetailsViewModelProtocol
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var mainView: ProductDetailsView = {
        let view = ProductDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: ProductDetailsViewModelProtocol) {
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

extension ProductDetailsViewController: ViewCodeConfiguration {
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

extension ProductDetailsViewController: ProductDetailsViewModelOutput {
    func updateState(_ state: ProductDetailsState) {
        switch state {
        case .loading:
            LoadingHUD.shared.start()
        case .loaded:
            LoadingHUD.shared.stop()
            guard let details = viewModel.productResponse else {
                return
            }
            mainView.setupDetails(for: details)
        case .error:
            LoadingHUD.shared.stop()
            if var stack = navigationController?.viewControllers {
                stack.removeLast()
                navigationController?.setViewControllers(stack, animated: false)
            }
            viewModel.coordinator.route(.error(.genericError))
        }
    }
}
