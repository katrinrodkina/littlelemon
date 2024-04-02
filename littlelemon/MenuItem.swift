//
//  MenuItem.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case descriptionDish = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
    
    var id = UUID()
    let title: String
    let image: String
    let price: String
    let descriptionDish: String
    let category: String
}
