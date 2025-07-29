//
//  SearchResultListViewControllerUITests.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import XCTest
import SnapshotTesting
@testable import MiniMeli

final class SearchResultListViewControllerUITests: XCTestCase {
    
    func test_searchResultListView_init() {
        // Arrange
        let nav = MockNavigationController()
        let mockCoordinator = MiniMeliCoordinator(nav)

        let mockProductService = MockProductService()
        let mockImageService = MockImageService()
        let mockSearchService = MockSearchService()

        let viewModel = SearchResultListViewModelImpl(
            coordinator: mockCoordinator,
            productService: mockProductService,
            imgService: mockImageService,
            searchService: mockSearchService,
            productsList: createProductList()
        )

        let vc = SearchResultListViewController(viewModel: viewModel)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        // Assert
        withSnapshotTesting(record: false) {
            assertSnapshot(of: vc, as: .image)
        }
    }
}

extension SearchResultListViewControllerUITests {
    func createProductList() -> [Product] {
        return [
            Product(
                id: "13123123123",
                title: "Arroz Integral 5kg",
                categoryId: "MLB123",
                thumbnail: "",
                currencyId: "BRL",
                price: 29.99,
                availableQuantity: 10,
                seller: Seller(id: 1, nickname: "ArrozStore")
            ),
            Product(
                id: "124",
                title: "Feijão Preto 1kg",
                categoryId: "MLB124",
                thumbnail: "",
                currencyId: "BRL",
                price: 9.99,
                availableQuantity: 15,
                seller: Seller(id: 2, nickname: "FeijaoExpress")
            ),
            Product(
                id: "125",
                title: "Óleo de Soja 900ml",
                categoryId: "MLB125",
                thumbnail: "",
                currencyId: "BRL",
                price: 7.49,
                availableQuantity: 20,
                seller: Seller(id: 3, nickname: "OleoStore")
            ),
            Product(
                id: "126",
                title: "Açúcar Refinado 1kg",
                categoryId: "MLB126",
                thumbnail: "",
                currencyId: "BRL",
                price: 4.99,
                availableQuantity: 30,
                seller: Seller(id: 4, nickname: "DoceVida")
            ),
            Product(
                id: "127",
                title: "Sal Refinado 1kg",
                categoryId: "MLB127",
                thumbnail: "",
                currencyId: "BRL",
                price: 3.99,
                availableQuantity: 25,
                seller: Seller(id: 5, nickname: "SalinasProdutos")
            )
        ]
    }
}
