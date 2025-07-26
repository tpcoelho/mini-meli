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
    private let searchService: SearchService
    
    init(coordinator: MiniMeliCoordinator, searchService: SearchService) {
        self.coordinator = coordinator
        self.searchService = searchService
    }
    
    func search(_ text: String?) {
        guard let textSearch = text else {
            // TODO: Criar Error
            coordinator.route(.error)
            return
        }
        LoadingHUD.shared.start()
        Task {
            do {
                let result = try await searchService.search(query: textSearch)
                await MainActor.run {
                    LoadingHUD.shared.stop()
                    self.coordinator.route(.searchResult(result))
                }
            } catch {
                await MainActor.run {
                    LoadingHUD.shared.stop()
                    // TODO: Criar Error
                    self.coordinator.route(.error)
                }
            }
        }
    }
}
