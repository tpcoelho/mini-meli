//
//  SearchViewModel.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var coordinator: MiniMeliCoordinator { get }
    
    func search(_ text: String?)
}

class SearchViewModelImpl: SearchViewModelProtocol {
    var coordinator: MiniMeliCoordinator
    
    init(coordinator: MiniMeliCoordinator) {
        self.coordinator = coordinator
    }
    
    func search(_ text: String?) {
        LoadingHUD.shared.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            LoadingHUD.shared.stop()
            self?.coordinator.route(.searchResult)
        }
    }
}
