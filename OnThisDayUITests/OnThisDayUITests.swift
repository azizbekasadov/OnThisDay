//
//  OnThisDayUITests.swift
//  OnThisDayUITests
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import XCTest

final class OnThisDayUITests: XCTestCase {

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
