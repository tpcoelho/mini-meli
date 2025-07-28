//
//  MiniMeliCoordinator.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

enum MiniMeliRoute {
    case search
    case searchResult([Product])
    case productDetails(Product)
    case error(ErrorType)
}

class MiniMeliCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    private var provider: RequestProvider = LocalNetwork()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    @MainActor
    func start() {
        provider = APINetwork()
        // FIXME: O code deveria ser inserido via deeplink. Atualize manualmente
//        OAuthSession.shared.clear()
        print(OAuthSession.shared.accessToken)
        if OAuthSession.shared.accessToken == nil {
            let alert = MiniMeliAlertView.create() { code in
                Task {
                    do {
                        let token = try await APINetwork().requestOAuthToken(code: code)
                        OAuthSession.shared.store(token: token)
                        print("✅ Token armazenado com sucesso")
                        let teste = Product(id: "", title: "", categoryId: "MLA389313", thumbnail: "", currencyId: "", price: 0.0, availableQuantity: 1, seller: Seller(id: 1, nickname: ""))
                        let description = try await ProductService(request: self.provider).searchProducts(query: "arroz")
                        print("✅ Descrição: \(description)")
                        self.route(.search)
                    } catch {
                        print("❌ Falha ao autenticar: \(error)")
                    }
                }
            }
            navigationController.present(alert, animated: true)
        } else {
            Task {
                do {
                    let teste = Product(id: "", title: "", categoryId: "MLA389313", thumbnail: "", currencyId: "", price: 0.0, availableQuantity: 1, seller: Seller(id: 1, nickname: ""))
                    let description = try await ProductService(request: self.provider).searchProducts(query: "arroz")
                    print("✅ Descrição: \(description)")
                    self.route(.search)
                } catch {
                    print("❌ Falha ao autenticar: \(error)")
                }
            }
            self.route(.search)
        }
    }
    
    func startMock() {
        provider = LocalNetwork()
        route(.search)
    }
    
    func route(_ route: MiniMeliRoute) {
        switch route {
        case .search:
            let viewModel = SearchViewModelImpl(coordinator: self, searchService: SearchService(request: provider))
            let vc = SearchViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .searchResult(let result):
            let viewModel = SearchResultListViewModelImpl(coordinator: self,
                                                          productService: ProductService(request: provider),
                                                          imgService: ImageService(request: provider),
                                                          searchService: SearchService(request: provider),
                                                          productsList: result)
            let vc = SearchResultListViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .productDetails(let selectedProduct):
            let viewModel = ProductDetailsViewModelImpl(coordinator: self,
                                                     productService: ProductService(request: provider),
                                                     imgService: ImageService(request: provider),
                                                     product: selectedProduct)
            let vc = ProductDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: false)
        case .error(let errorType):
            let vc = ErrorViewController(error: errorType.getErrorObj())
            navigationController.pushViewController(vc, animated: false)
        }
    }
}
