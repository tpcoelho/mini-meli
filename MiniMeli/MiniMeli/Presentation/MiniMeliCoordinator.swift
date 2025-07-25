//
//  MiniMeliCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

class MiniMeliCoordinator: BaseCoordinator {
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       print("geting token...")
    }
    
    func startMock() {
        let vc = SearchViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
