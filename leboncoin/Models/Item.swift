//
//  Item.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation

struct Item: Codable {
    var id, category_id: Int!
    var title, description, creation_date: String!
    var images_url : Image_url?
    var price: Double!
    var is_urgent: Bool!
    
}

struct Image_url : Codable {
    var small: String?
    var thumb : String?
}
