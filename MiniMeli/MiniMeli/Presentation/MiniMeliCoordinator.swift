//
//  MiniMeliCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

enum MiniMeliRoute {
    case search
    case searchResult
    case itemDetails
    case error
}

class MiniMeliCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("geting token...")
    }
    
    func startMock() {
        route(.search)
    }
    
    func route(_ route: MiniMeliRoute) {
        switch route {
        case .search:
            let viewModel = SearchViewModelImpl(coordinator: self)
            let vc = SearchViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .searchResult:
            print("open searchResult")
            break
        case .itemDetails:
            print("open itemDetails")
            break
        case .error:
            // Handler any error on this flow
            break
        }
    }
}
