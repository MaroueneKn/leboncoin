//
//  ListItemsViewModel.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation

class ListItemsViewModel : FilterViewControllerDelegate {
    
    var categorys = [Category]()
    var allItems = [Item]()
    var initialList = [Item]()
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    
    func getItemList(completionHandler: @escaping CompletionHandler) {
        removeAllKeys()
        let item = Item()
        Service.shared.getData(item) { response in
            switch response {
            case .results(let results) :
                self.initialList = results
                self.allItems = results
                completionHandler(true)
            case .error(_):
            completionHandler(false)
            }
        }
    }
    
    func getCategories(completionHandler: @escaping CompletionHandler) {
        removeAllKeys()
        let category = Category()
        Service.shared.getData(category) { response in
            switch response {
            case .results(let results) :
                self.categorys = results
                completionHandler(true)
            case .error(_):
            completionHandler(false)
            }
        }
    }
    
    
    func applyFilter(_ controller: FilterCollectionViewController, category_id: Int?) {
        self.allItems = initialList
        if let category_id = category_id {
            let filteredItems = allItems.filter { $0.category_id == category_id }
            self.allItems = filteredItems.sorted(by: {$0.is_urgent && !$1.is_urgent})
        }
    }
    
    
    func removeAllKeys() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.category_id)
        UserDefaults.standard.removeObject(forKey: UserDefaults.sort_type)
    }
    
}
