//
//  Onboarding.swift
//  littlelemon
//
//  Created by katrina on 4/1/24.
//

import SwiftUI

let kFirstNameKey = "userFirstNameKey"
let kLastNameKey = "userLastNameKey"
let kEmailKey = "userEmailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @State private var showAlert = false
    
    @State private var isLoggedIn = false
    
    
    var body: some View {
        Spacer()
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Form {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                    Section {
                        Button ("Register") {
                            if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, isValidEmail(email) {
                                UserDefaults.standard.set(firstName, forKey: kFirstNameKey)
                                UserDefaults.standard.set(lastName, forKey: kLastNameKey)
                                UserDefaults.standard.set(email, forKey: kEmailKey)
                                
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                               
                                isLoggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                    }
                }
                .padding()
                
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill all fields correctly"), dismissButton: .default(Text("OK")))
        }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    
}

#Preview {
    Onboarding()
}
