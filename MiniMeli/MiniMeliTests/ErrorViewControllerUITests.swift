//
//  ErrorViewControllerUITests.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import XCTest
import SnapshotTesting
@testable import MiniMeli

final class ErrorViewControllerUITests: XCTestCase {
    
    func testErrorViewControllerSnapshot() {
        // Arrange
        let vc = ErrorViewController(error: ErrorType.genericError.getErrorObj())
        
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667) // iPhone 8
        
        withSnapshotTesting(record: false) {
            assertSnapshot(of: vc, as: .image)
        }
    }
}
