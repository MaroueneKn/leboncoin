//
//  ItemsTests.swift
//  leboncoinTests
//
//  Created by Kandara Marouene on 07/11/2022.
//

import XCTest
@testable import leboncoin


final class ItemsTests : XCTestCase {
    
    func testGetItems() {
        let viewModel = ListItemsViewModel()
        
        viewModel.getItemList(completionHandler: { success in
            if success {
                XCTAssertTrue(viewModel.allItems.count > 0)
            }
        })
    }
    
    func testItem() {
        let item = createItem(title: "test", catId: 1)
        XCTAssertEqual(item.category_id, 1)
        XCTAssertEqual(item.title, "test")
    }
    
     func testFilterdItem() {
         let viewModel = ListItemsViewModel()
         let filterViewModel = FilterViewModel()
         let item1 = createItem(title: "item1", catId: 1)
         viewModel.initialList.append(item1)
         viewModel.applyFilter(FilterCollectionViewController(filterViewModel), category_id: 1)
         
         XCTAssertTrue(viewModel.allItems.count > 0)
         
         let item2 = createItem(title: "item2", catId: 1)
         let item3 = createItem(title: "item3", catId: 2)
         let item4 = createItem(title: "item4", catId: 2)
         let item5 = createItem(title: "item5", catId: 3)
         let item6 = createItem(title: "item6", catId: 1)

         viewModel.initialList.append(item2)
         viewModel.initialList.append(item3)
         viewModel.initialList.append(item4)
         viewModel.initialList.append(item5)
         viewModel.initialList.append(item6)
         
         viewModel.applyFilter(FilterCollectionViewController(filterViewModel), category_id: 1)
         XCTAssertEqual(viewModel.allItems.count, 3)
         
         viewModel.applyFilter(FilterCollectionViewController(filterViewModel), category_id: 2)
         XCTAssertEqual(viewModel.allItems.count, 2)
         
         viewModel.applyFilter(FilterCollectionViewController(filterViewModel), category_id: 3)
         XCTAssertEqual(viewModel.allItems.count, 1)
         
         viewModel.applyFilter(FilterCollectionViewController(filterViewModel), category_id: 4)
         XCTAssertEqual(viewModel.allItems.count, 0)
     }
    
    
    func testGetCategory() {
        let viewModel = ListItemsViewModel()
        let categorys: () = viewModel.getCategories { success in
            if success {
                XCTAssertTrue(viewModel.categorys.count > 0)
            }
        }
        XCTAssertNotNil(categorys)

    }
    
    func createItem(title:String, catId: Int) -> Item {
        var item = Item()
        item.category_id = catId
        item.title = title
        item.description = "desc"
        item.creation_date = ""
        item.price = 100
        item.is_urgent = true
        return item
    }
}
