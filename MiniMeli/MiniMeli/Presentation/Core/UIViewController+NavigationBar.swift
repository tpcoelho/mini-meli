//
//  UIViewController+NavigationBar.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//

import UIKit

extension UIViewController {
    func setupNavigationBar() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = Colors.Action.primary
        navigationItem.backBarButtonItem = backItem
    }
}
