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
    case itemDetails
    case error
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
            print("open searchResult ", result.count)
            let viewModel = SearchResultListViewModelImpl(coordinator: self, service: ItemService(request: provider), productsList: result)
            let vc = SearchResultListViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .itemDetails:
            print("open itemDetails")
            break
        case .error:
            // Handler any error on this flow
            break
        }
    }
}
