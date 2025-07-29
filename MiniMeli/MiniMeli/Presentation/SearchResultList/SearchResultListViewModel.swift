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
    
    func loadImage(for url: String) async -> Data?
    func search(_ text: String?)
}
enum SearchResultListState {
    case loading
    case loaded
    case refreshList
    case goToDetails(Product)
    case error
}

@MainActor
protocol SearchResultListViewModelOutput: AnyObject {
    func updateState(_ state: SearchResultListState)
}

class SearchResultListViewModelImpl: SearchResultListViewModelProtocol {
    
    let coordinator: MiniMeliCoordinator
    var productsList: [Product]
    weak var viewOutput: SearchResultListViewModelOutput?
    
    private let productService: ProductServiceProtocol
    private let imgService: ImageServiceProtocol
    private let searchService: SearchServiceProtocol
    
    init(coordinator: MiniMeliCoordinator,
         productService: ProductServiceProtocol,
         imgService: ImageServiceProtocol,
         searchService: SearchServiceProtocol,
         productsList: [Product] = []) {
        self.coordinator = coordinator
        self.productService = productService
        self.imgService = imgService
        self.searchService = searchService
        self.productsList = productsList
    }

    func loadImage(for url: String) async -> Data? {
        return try? await imgService.getImage(from: url)
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
                productsList = result
                await self.viewOutput?.updateState(.refreshList)
            } catch {
                print(error)
                await self.viewOutput?.updateState(.error)
            }
        }
    }
}
