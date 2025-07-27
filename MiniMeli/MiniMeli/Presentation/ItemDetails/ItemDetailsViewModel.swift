//
//  ItemDetailsViewModel.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//

import Foundation
import UIKit

protocol ItemDetailsViewModelProtocol: AnyObject {
    var coordinator: MiniMeliCoordinator { get }
    var viewOutput: ItemDetailsViewModelOutput? { get set }
    var product: Product { get }
    var productResponse: ProductDetailsResponse? { get }
    
    func viewDidLoad()
}
enum ItemDetailsState {
    case loading
    case loaded
}

@MainActor
protocol ItemDetailsViewModelOutput: AnyObject {
    func updateState(_ state: ItemDetailsState)
}

class ItemDetailsViewModelImpl: ItemDetailsViewModelProtocol {
    let coordinator: MiniMeliCoordinator
    var product: Product
    var productResponse: ProductDetailsResponse?
    
    weak var viewOutput: ItemDetailsViewModelOutput?
    
    private let productService: ProductService
    private let imgService: ImageService
    
    init(coordinator: MiniMeliCoordinator,
         productService: ProductService,
         imgService: ImageService,
         product: Product) {
        self.coordinator = coordinator
        self.productService = productService
        self.imgService = imgService
        self.product = product
    }
    
    func viewDidLoad() {
        Task { [weak self] in
            guard let self = self else { return }
            
            await self.viewOutput?.updateState(.loading)
            do {
                async let productDetails = try productService.getProductDetails(productId: product.id)
                async let category = try productService.getCategory(productId: product.id)
                async let description = try productService.getDescription(productId: product.id)
                
                let (details, cat, desc) = try await (productDetails, category, description)
                
                let imageURLs = details.pictures.map { $0.secureUrl }
                var images: [UIImage] = []
                
                for url in imageURLs {
                    if let data = try await imgService.getItmage(from: url),
                       let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
                
                self.productResponse = ProductDetailsResponse(
                    product: self.product,
                    productDetails: details,
                    productDescription: desc,
                    category: cat,
                    images: images
                )
                await self.viewOutput?.updateState(.loaded)
            } catch {
                print("Erro ao carregar detalhes: \(error.localizedDescription)")
                // TODO: criar erro
                await self.viewOutput?.updateState(.loaded)
                self.coordinator.route(.error)
            }
        }
    }
}
