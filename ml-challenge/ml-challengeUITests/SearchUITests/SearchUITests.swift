//
//  SearchUITests.swift
//  ml-challengeUITests
//
//  Created by Christian Alberton Alexandre on 24/06/24.
//

import Foundation
import XCTest

final class SearchUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Do anything
    }
    
    func testSearchDisplaysResults() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["searchItemTextField"]
        XCTAssertTrue(searchTextField.exists, "Search text field error")
        searchTextField.tap()
        searchTextField.typeText("macbook\n")
        
        let tableView = app.tables["itemsTableView"]
        let firstResult = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstResult.waitForExistence(timeout: 5), "Failed to search items")
    }
}
