//
//  FilterViewModel.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import Foundation


class FilterViewModel {
    
    var currentIndexPath : IndexPath?
    var items = [Item]()
    var categorys = [Category]()
    var category_id : Int?
    weak var delegate: FilterViewControllerDelegate?

    init() {}
    
    init(items: [Item], categorys : [Category]) {
        self.items = items
        self.categorys = categorys
    }
    
    func filter (controller: FilterCollectionViewController, category_id:Int?) {
        delegate?.applyFilter(controller, category_id: category_id)
    }
    
    func resetFilter() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.category_id)
    }
    
    func getCategory() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.category_id)
    }

    func saveCategory(_ category_id : Int?) {
        return UserDefaults.standard.set(category_id, forKey: UserDefaults.category_id)
    }
    
    func removeCategoryId() {
        category_id = nil
        UserDefaults.standard.removeObject(forKey: UserDefaults.category_id)
    }
}


protocol FilterViewControllerDelegate: AnyObject {
    func applyFilter(_ controller: FilterCollectionViewController, category_id: Int?)
}
