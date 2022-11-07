//
//  DetailsViewModel.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import Foundation

class DetailsViewModel {
   
    var thumbImageUrl: String?
    var categoryName : Category
    var title: String
    var price: Double
    var creation_date: Date?
    var description: String
    var is_urgent: Bool
  
    init(item:Item,  categoryName: Category) {
        self.thumbImageUrl = item.images_url?.thumb
        self.title = item.title
        self.price = item.price
        self.categoryName = categoryName
        self.description = item.description
        self.is_urgent = item.is_urgent
        if let creation_date = item.creation_date {
            self.creation_date = DateHandler.stringToDate(creation_date)
        }
    }
    
}
