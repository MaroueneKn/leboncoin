//
//  FilterTests.swift
//  leboncoinTests
//
//  Created by Kandara Marouene on 07/11/2022.
//

import XCTest
@testable import leboncoin

final class FilterTest : XCTestCase {
    
    func testGetSavedCategoryId() {
        let viewModel = FilterViewModel()
        viewModel.saveCategory(1)
        let savedId = viewModel.getCategory()
        XCTAssertEqual(savedId, 1)
    }
    
    func testResetFilter() {
        let viewModel = FilterViewModel()
        viewModel.saveCategory(1)
        viewModel.resetFilter()
        let savedCategoryId = viewModel.getCategory()
        XCTAssertEqual(savedCategoryId, Int())
        XCTAssertNotEqual(savedCategoryId, 1)
    }
    
}
