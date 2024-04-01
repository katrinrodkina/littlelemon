//
//  Menu.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

struct Menu: View {
    @State private var menuItems = [MenuItem]()
    @State private var searchText = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    

 
    init() {
        _searchText = State(initialValue: "") // Initialize searchText with an empty string
        
        fetchRequest = FetchRequest<Dish>(
            entity: Dish.entity(),
            sortDescriptors: [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        )
    }
    var fetchRequest: FetchRequest<Dish>
    var dishes: FetchedResults<Dish> { fetchRequest.wrappedValue }

   
    var body: some View {
        VStack {
            Text("Little Lemon").font(.title)
            Text("New York")
            Text("Meditarranean restaurant").font(.subheadline)
            Spacer()
            
            // Display the fetched Dish items in a List
            TextField("Search menu", text: $searchText)
                   .padding()
            List {
                ForEach(dishes, id: \.self) { dish in
                    HStack {
                        // Display dish title and price
                        Text("\(dish.title ?? "Unknown Dish") - $\(dish.price ?? "")")
                        // Display dish image using AsyncImage
                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50) // Set the image size
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData () {
        //make sure that the database is cleared of all the Dish data before fetching and storing the new ones again.
        PersistenceController.shared.clear()
        
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
            // Check for errors, make sure we got data
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            // Attempt to decode the data from JSON to our Swift structs
            do {
                let decodedData = try JSONDecoder().decode(MenuList.self, from: data)
                for menuItem in decodedData.menu {
                    // Create a new Dish object for each MenuItem
                    let dish  = Dish(context: self.viewContext)
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                }
                // Save the context to persist the new Dish objects, save to database
                try? self.viewContext.save()
                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
            }
            
        }
        
        
        task.resume()  // Start the network task
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
         return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
     }
    
    

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

#Preview {
    Menu()
}
