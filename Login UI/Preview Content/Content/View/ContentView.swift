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

      
        @State  var navigate = viewModel.tokenData != ""

        NavigationStack{
            VStack() {
                Form{
                    Section{
                        TextField("Enter  your email",text:  $viewModel.email)
                        TextField("Enter your Password",text:  $viewModel.password)
                        Text( viewModel.email)
                        Text( viewModel.password)
                        Text(viewModel.responseModel?.token ?? "")
                    }
                    Section{
                        Button("Login"){
                            viewModel.loginRequest()
                            navigate = true
               
                        }
                        .navigationDestination(isPresented: $navigate ) {
                            Home(email:viewModel.email) // Navigate to Home view
                        }
                        
                    }.disabled( viewModel.email.count<5 ||  viewModel.password.count<5 || !viewModel.email.contains("@"))
                    Button("Delete value pair for this email"){
                        viewModel.deleteValue()
                    }
                }
                Button("Update Password to keychain"){
                    viewModel.updatePassword()
                }.padding()
                Button("Get Password from keychain"){
                    viewModel.retrivePassword()
                }
            }.onAppear{
                viewModel.retriveToken()
            }
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
