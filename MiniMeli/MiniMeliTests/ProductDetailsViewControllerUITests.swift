//
//  ProductDetailsViewControllerUITests.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//


import XCTest
import SnapshotTesting
@testable import MiniMeli

final class ProductDetailsViewControllerUITests: XCTestCase {
    
    func test_productDetailsView_init() {
        // Arrange
        let nav = MockNavigationController()
        let mockCoordinator = MiniMeliCoordinator(nav)

        let mockProductService = MockProductService()
        let mockImageService = MockImageService()
        let mockSearchService = MockSearchService()

        let mockProduct = Product(
            id: "13123123123",
            title: "Arroz Integral 5kg",
            categoryId: "MLB123",
            thumbnail: "",
            currencyId: "BRL",
            price: 29.99,
            availableQuantity: 10,
            seller: Seller(id: 1, nickname: "ArrozStore")
        )
        
        let viewModel = ProductDetailsViewModelImpl(
            coordinator: mockCoordinator,
            productService: mockProductService,
            imgService: mockImageService,
            product: mockProduct
        )

        setupMock(service: mockProductService)
        let vc = ProductDetailsViewController(viewModel: viewModel)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        // Assert
        withSnapshotTesting(record: false) {
            assertSnapshot(of: vc, as: .image)
        }
    }
}

extension ProductDetailsViewControllerUITests {
    func setupMock(service: MockProductService) {
        let detailsResult = ProductDetails(
            id: "MLA123456789",
            title: "Arroz Integral Premium 5kg",
            currencyId: "BRL",
            price: 32.90,
            condition: "new",
            thumbnail: "https://example.com/thumb.jpg",
            pictures: [
                ProductImage(
                    id: "1",
                    url: "https://example.com/img1.jpg",
                    secureUrl: "https://example.com/img1.jpg",
                    size: "500x500",
                    maxSize: "1000x1000",
                    quality: "high"
                ),
                ProductImage(
                    id: "2",
                    url: "https://example.com/img2.jpg",
                    secureUrl: "https://example.com/img2.jpg",
                    size: "600x600",
                    maxSize: "1200x1200",
                    quality: "high"
                )
            ],
            sellerAddress: SellerAddress(
                id: 987654,
                city: Location(id: "BR-FLN", name: "Florianópolis"),
                state: Location(id: "BR-SC", name: "Santa Catarina"),
                country: Location(id: "BR", name: "Brasil")
            ))
        let categoryResult = ProductCategory(
            id: "MLB12345",
            name: "Alimentos",
            pathFromRoot: [
                SubCategory(id: "root", name: "Loja"),
                SubCategory(id: "food", name: "Alimento"),
                SubCategory(id: "rice", name: "Arroz")
            ])
        let descriptionResult = ProductDescription(
            text: "",
            plainText: """
                Arroz integral premium 5kg, ideal para uma alimentação saudável.
                Rico em fibras e nutrientes. Pode ser usado em receitas variadas.
                """,
            lastUpdated: "2024-05-22T13:48:57.158Z",
            dateCreated: "2024-05-22T13:48:57.158Z"
        )
        
        service.detailsResult = detailsResult
        service.categoryResult = categoryResult
        service.descriptionResult = descriptionResult
    }
}
