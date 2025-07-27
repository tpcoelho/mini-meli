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
    
    func openDetails(for selectedItem: Product)
    func loadImage(for url: String) async -> Data?
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
    
    private let itemService: ItemService
    private let imgService: ImageService
    
    init(coordinator: MiniMeliCoordinator,
         itemService: ItemService,
         imgService: ImageService,
         productsList: [Product] = []) {
        self.coordinator = coordinator
        self.itemService = itemService
        self.imgService = imgService
        self.productsList = productsList
    }
    
    func openDetails(for selectedItem: Product) {
        coordinator.route(.itemDetails)
    }
    
    func loadImage(for url: String) async -> Data? {
        return try? await imgService.getItmage(from: url)
    }
}
