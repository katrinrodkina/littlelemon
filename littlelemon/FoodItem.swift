//
//  FoodItem.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//


import SwiftUI

struct FoodItem: View {
    
    let dish:Dish
    
    var body: some View {
        HStack {
            VStack {
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                Spacer(minLength: 10)
                Spacer(minLength: 5)
                Text("$" + (dish.price ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .monospaced()
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 90, maxHeight: 90)
            .clipShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxHeight: 150)
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(dish: PersistenceController.oneDish())
    }
    
}
