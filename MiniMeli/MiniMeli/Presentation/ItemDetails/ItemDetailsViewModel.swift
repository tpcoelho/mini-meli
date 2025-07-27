//
//  ItemDetailsViewModel.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


protocol ItemDetailsViewModelProtocol: AnyObject {
    var coordinator: MiniMeliCoordinator { get }
    var viewOutput: ItemDetailsViewModelOutput? { get set }
    var product: Product { get }
    
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
    weak var viewOutput: ItemDetailsViewModelOutput?
    
    private let itemService: ItemService
    private let imgService: ImageService
    
    init(coordinator: MiniMeliCoordinator,
         itemService: ItemService,
         imgService: ImageService,
         product: Product) {
        self.coordinator = coordinator
        self.itemService = itemService
        self.imgService = imgService
        self.product = product
    }
    
    func viewDidLoad() {
        Task { [weak self] in
            guard let self = self else { return }
            await self.viewOutput?.updateState(.loading)
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            await self.viewOutput?.updateState(.loaded)
        }
    }
}
