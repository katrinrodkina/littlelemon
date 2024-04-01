//
//  UserProfile.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation // This will automatically reference the presentation environment in SwiftUI w
    
    
    let userFirstName = UserDefaults.standard.string(forKey: kFirstNameKey) ?? ""
    let userLastName = UserDefaults.standard.string(forKey: kLastNameKey) ?? ""
    let userEmail = UserDefaults.standard.string(forKey: kEmailKey) ?? ""
    
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("Profile")
                .resizable()
                .frame(width: 200, height: 200)
            // Displaying user information
            Text(userFirstName)
                .padding(.top, 20)
            Text(userLastName)
                .padding(.top, 2)
            Text(userEmail)
                .padding(.top, 2)
            Spacer()
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn) // Reset login flag
                self.presentation.wrappedValue.dismiss() // Dismiss UserProfile view
            }
            Spacer()
        }.padding(100)
    }
}

#Preview {
    UserProfile()
}
