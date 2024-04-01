//
//  Home.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

struct Home: View {
    // Initialize persistence controller
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .font(.title)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem({
                    Label("Menu",
                          systemImage: "list.dash")
                })
                
            
            UserProfile()
                .font(.title)
                .tabItem({
                    Label("Profile",
                          systemImage: "square.and.pencil")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
