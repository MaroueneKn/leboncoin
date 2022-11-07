//
//  EnvironmentTests.swift
//  leboncoinTests
//
//  Created by Kandara Marouene on 07/11/2022.
//

import XCTest
@testable import leboncoin

final class EnvironnementTests: XCTestCase {
    
    func testUrlTypes() {
        let item = Item()
        if let url = Environment.urlType(item) {
            XCTAssertTrue(url.absoluteString.contains("listing.json"))
        }

        let category = Category()
        if let url = Environment.urlType(category) {
            XCTAssertTrue(url.absoluteString.contains("categories.json"))
        }
        
        let randomString = "randomString"
        if let url = Environment.urlType(randomString) {
            XCTAssertTrue(url.absoluteString.contains("listing.json"))
        }
        
    }
    
}
