//
//  SearchViewControllerUITests.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//


import XCTest
import SnapshotTesting
@testable import MiniMeli

final class SearchViewControllerUITests: XCTestCase {
    
    func test_init() {
        // Arrange
        let nav = MockNavigationController()
        let mockCoordinator = MiniMeliCoordinator(nav)
        let viewModel = SearchViewModelImpl(coordinator: mockCoordinator, searchService: MockSearchService())
        let vc = SearchViewController(viewModel: viewModel)
        
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667) // iPhone 8
        
        withSnapshotTesting(record: false) {
            assertSnapshot(of: vc, as: .image)
        }
    }
}
