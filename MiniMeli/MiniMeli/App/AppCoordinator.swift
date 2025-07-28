//
//  AppCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 22/07/25.
//


import UIKit

class AppCoordinator: BaseCoordinator {
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        let vc = PreLoginViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
