import Foundation
import CoreData

class MenuViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchDishes()
    }
    
    func fetchDishes(predicate: NSPredicate? = nil) {
        let request: NSFetchRequest<Dish> = Dish.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        request.predicate = predicate
        
        do {
            dishes = try viewContext.fetch(request)
        } catch {
            print("Dish fetch failed: \(error.localizedDescription)")
        }
    }
    
    func updateFetchPredicate(searchText: String) {
        if searchText.isEmpty {
            fetchDishes()
        } else {
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            fetchDishes(predicate: predicate)
        }
    }
    
    func refreshDishes() {
          fetchDishes() // Call existing method to refetch dishes
      }
}
