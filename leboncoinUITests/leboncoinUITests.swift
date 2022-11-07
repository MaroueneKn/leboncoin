//
//  leboncoinUITests.swift
//  leboncoinUITests
//
//  Created by Kandara Marouene on 07/11/2022.
//

import XCTest
@testable import leboncoin

final class leboncoinUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }
    
    func testNavigation() {
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func testDetailsPAge() {
        let title = app.tables.element(boundBy: 0).cells.element(boundBy: 0).staticTexts.element(boundBy: 0).title
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        let title1 = app.staticTexts.element(boundBy: 1).title
        XCTAssertEqual(title, title1)
    }
    
    func testFilter() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        let category = app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0)
        let category_name = category.title
        category.tap()
        app.buttons.element(boundBy: 2).tap()
        self.app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        let title1 = self.app.staticTexts.element(boundBy: 1).title
        XCTAssertEqual(category_name, title1)
    }
    
}
