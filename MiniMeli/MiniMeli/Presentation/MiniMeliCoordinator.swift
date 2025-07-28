//
//  MiniMeliCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

enum MiniMeliRoute {
    case search
    case searchResult([Product])
    case productDetails(Product)
    case error(ErrorType)
}

class MiniMeliCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    private var provider: RequestProvider = LocalNetwork()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        print("geting token...")
    }
    
    func startMock() {
        provider = LocalNetwork()
        route(.search)
    }
    
    func route(_ route: MiniMeliRoute) {
        switch route {
        case .search:
            let viewModel = SearchViewModelImpl(coordinator: self, searchService: SearchService(request: provider))
            let vc = SearchViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .searchResult(let result):
            let viewModel = SearchResultListViewModelImpl(coordinator: self,
                                                          productService: ProductService(request: provider),
                                                          imgService: ImageService(request: provider),
                                                          searchService: SearchService(request: provider),
                                                          productsList: result)
            let vc = SearchResultListViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .productDetails(let selectedProduct):
            let viewModel = ProductDetailsViewModelImpl(coordinator: self,
                                                     productService: ProductService(request: provider),
                                                     imgService: ImageService(request: provider),
                                                     product: selectedProduct)
            let vc = ProductDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .error(let errorType):
            let vc = ErrorViewController(error: errorType.getErrorObj())
            navigationController.pushViewController(vc, animated: false)
        }
    }
}
