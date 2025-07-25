//
//  AppCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 22/07/25.
//


import UIKit

protocol BaseCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}

/// App coordinator is the only one coordinator which will exist during app's life cycle
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
