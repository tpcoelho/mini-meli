//
//  BaseCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import UIKit

protocol BaseCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
