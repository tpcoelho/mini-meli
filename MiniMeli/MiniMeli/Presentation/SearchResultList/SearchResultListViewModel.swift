//
//  SearchResultListViewModel.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import Foundation

protocol SearchResultListViewModelProtocol: AnyObject {
    var coordinator: MiniMeliCoordinator { get }
    var viewOutput: SearchResultListViewModelOutput? { get set }
    var productsList: [Product] { get set }
    
    func viewDidLoad()
    func openDetails(for selectedItem: Product)
}
enum SearchResultListState {
    case loading
    case loaded
}
protocol SearchResultListViewModelOutput: AnyObject {
    func updateState(_ state: SearchResultListState)
}

class SearchResultListViewModelImpl: SearchResultListViewModelProtocol {
    
    let coordinator: MiniMeliCoordinator
    var productsList: [Product]
    weak var viewOutput: SearchResultListViewModelOutput?
    
    private let service: ItemService
    
    init(coordinator: MiniMeliCoordinator, service: ItemService, productsList: [Product] = []) {
        self.coordinator = coordinator
        self.service = service
        self.productsList = productsList
    }
    
    func viewDidLoad() {
        Task { [weak self] in
            await self?.loadListItem()
        }
    }
    
    func openDetails(for selectedItem: Product) {
        coordinator.route(.itemDetails)
    }
    
    @MainActor
    private func loadListItem() async {
//        viewOutput?.updateState(.loading)
//        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
//        self.currentSummary = self.storage.getSummary() ?? KingdomSummaryModel()
//        self.viewOutput?.updateState(.refreshList(self.currentSummary))
    }
}
