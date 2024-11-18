//
//  ContentView.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/15/24.
//

import SwiftUI

struct ContentView: View {

    @State private var viewModel = ViewModel()
    @State private var navigate = false
    var body: some View {
        NavigationStack{
            VStack() {

                Form{
                    
                    Section{
                        TextField("Enter your email",text:  $viewModel.email)
                        TextField("Enter your Password",text:  $viewModel.password)
                        
                    }
                    Section{
                                Button("Login"){
                                    viewModel.pressed()
                                    navigate = true
                                }
                                .navigationDestination(isPresented: $navigate) {
                                    Home(email:viewModel.email) // Navigate to Home view
                                            }
                            
                                
                            
            
                    }.disabled( viewModel.email.count<5 ||  viewModel.password.count<5 || !viewModel.email.contains("@"))
                }

            }
            
            
       
        }
    }
}

#Preview {
    ContentView()
}
