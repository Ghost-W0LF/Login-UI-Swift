//
//  ContentView.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/15/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var viewModel = ViewModel()

    
    
    var body: some View {
        @State  var token = viewModel.responseModel?.token
        @State var navigate = false
        NavigationStack{
            VStack() {
                Form{
                    Section{
                        TextField("Enter your email",text:  $viewModel.email)
                        TextField("Enter your Password",text:  $viewModel.password)
                        Text(viewModel.email )
                        Text(viewModel.responseModel?.token ?? "")
                    }
                    Section{
                        Button("Login"){
                            viewModel.loginRequest()
               
                        }
                        .navigationDestination(isPresented: $navigate
                      
                        ) {
                            Home(email:viewModel.email) // Navigate to Home view
                        }
                        
                    }.disabled( viewModel.email.count<5 ||  viewModel.password.count<5 || !viewModel.email.contains("@"))
                }
                Button("Update Password to keychain"){
                    viewModel.updatePassword()
                }.padding()
                Button("Get Password from keychain"){
                    viewModel.retrivePassword()
                }
            }
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
