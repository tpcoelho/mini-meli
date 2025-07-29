//
//  SearchViewModel.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 25/07/25.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var coordinator: MiniMeliCoordinator { get }
    var viewOutput: SearchViewModelOutput? { get set }
    
    func search(_ text: String?)
}

@MainActor
protocol SearchViewModelOutput: AnyObject {
    func updateState(_ state: SearchState)
}

enum SearchState {
    case loading
    case loaded([Product])
    case error
}

class SearchViewModelImpl: SearchViewModelProtocol {
    
    var coordinator: MiniMeliCoordinator
    private let searchService: SearchServiceProtocol
    weak var viewOutput: SearchViewModelOutput?
    
    init(coordinator: MiniMeliCoordinator, searchService: SearchServiceProtocol) {
        self.coordinator = coordinator
        self.searchService = searchService
    }
    
    func search(_ text: String?) {
        Task { [weak self] in
            guard let self = self else { return }
            guard let textSearch = text else {
                return
            }
            await self.viewOutput?.updateState(.loading)
            do {
                let result = try await searchService.search(query: textSearch)
                await viewOutput?.updateState(.loaded(result))
            } catch {
                print(error)
                await self.viewOutput?.updateState(.error)
            }
        }
    }
}
