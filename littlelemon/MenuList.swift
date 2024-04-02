//
//  MenuList.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import Foundation
import CoreData

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
    
    static func getMenuData(viewContext: NSManagedObjectContext) {
        //make sure that the database is cleared of all the Dish data before fetching and storing the new ones again.
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let fullMenu = try? decoder.decode(MenuList.self, from: data) {
                    for dish in fullMenu.menu {
                        // Create a new Dish object for each MenuItem
                        let newDish = Dish(context: viewContext)
                        newDish.title = dish.title
                        newDish.price = dish.price
//                        newDish.descriptionDish = dish.descriptionDish
                        newDish.image = dish.image
//                        newDish.category = dish.category
                    }
                    // Save the context to persist the new Dish objects, save to database
                    try? viewContext.save()
                } else {
                    print(error.debugDescription.description)
                }
            } else {
                print(error.debugDescription.description)
            }
        }
        dataTask.resume()
    }
}
