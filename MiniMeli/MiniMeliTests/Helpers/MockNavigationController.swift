//
//  MockNavigationController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import UIKit

final class MockNavigationController: UINavigationController {
    private(set) var pushedViewControllers: [UIViewController] = []
    private(set) var presentedViewControllers: [UIViewController] = []

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        super.pushViewController(viewController, animated: false)
    }

    override func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllers.append(viewControllerToPresent)
        super.present(viewControllerToPresent, animated: false, completion: completion)
    }
    
    func didPush<T: UIViewController>(_ type: T.Type) -> Bool {
        pushedViewControllers.contains { $0 is T }
    }

    func didPresent<T: UIViewController>(_ type: T.Type) -> Bool {
        presentedViewControllers.contains { $0 is T }
    }
}
