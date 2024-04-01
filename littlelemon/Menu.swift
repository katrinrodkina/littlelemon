//
//  Menu.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack{
            Text("Little Lemon").font(.title)
            Text("New York")
            Text("Meditarranean restaurant").font(.subheadline)
            Spacer()
            
            List {
                
            }
        }
    }
}

#Preview {
    Menu()
}
