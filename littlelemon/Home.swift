//
//  Home.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .font(.title)
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
