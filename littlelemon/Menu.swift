//
//  Menu.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject private var viewModel: MenuViewModel
    
    @State private var menuItems = [MenuItem]()
    @State private var searchText = ""
    
    
    

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: MenuViewModel(context: context))
    }
    

   
    var body: some View {
        VStack {
            Text("Little Lemon").font(.title)
            Text("New York")
            Text("Meditarranean restaurant").font(.subheadline)
            Spacer()
            
            // Display the fetched Dish items in a List
            TextField("Search menu", text: $searchText)
                   .padding()
                   .textFieldStyle(.roundedBorder)
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List(dishes) { dish in
                    NavigationLink(destination: DetailItem(dish: dish)) {
                        FoodItem(dish: dish)
                    }
                }
                .listStyle(.plain)
            }
//            List {
//                ForEach(viewModel.dishes, id: \.self) { dish in
//                    HStack {
//                        // Display dish title and price
//                        Text("\(dish.title ?? "Unknown Dish") - $\(dish.price ?? "")")
//                        // Display dish image using AsyncImage
//                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
//                            image.resizable()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: 50, height: 50) // Set the image size
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//            }
        }
        .onAppear {
            MenuList.getMenuData(viewContext: viewContext)
        }
    }

    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(context: PersistenceController.shared.container.viewContext).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}


//struct Menu_Previews: PreviewProvider {
//    static var previews: some View {
//        // Directly initialize PersistenceController if a preview instance isn't set up
//        let persistenceController = PersistenceController.shared
//        
//        // Use the viewContext from the newly created persistence controller
//        Menu(context: persistenceController.container.viewContext)
//    }
//}
