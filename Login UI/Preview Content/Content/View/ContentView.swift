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
        @State  var isShowingIncorrecrAleart = viewModel.isShowingIncorectPassword
        NavigationStack{
            VStack() {
                Form{
                    Section{
                        TextField("Enter  your email",text:  $viewModel.email)
                        TextField("Enter your Password",text:  $viewModel.password)
                    }
                    Section{
                        Button("Login"){
                            viewModel.loginRequest()
                 
                        }
                        .navigationDestination(isPresented: $navigate ) {
                            Home(email:viewModel.email) // Navigate to Home view
                        }
                    }.disabled(viewModel.validation())
                    
                    Button("Delete value pair for this email"){
                        viewModel.deleteValue()
                    }
                }
                Button("Update Password to  keychain"){
                    viewModel.updatePassword()
                }.padding()
                Button("Get Password from keychain"){
                    viewModel.retrivePassword()
                }
            }.onAppear{
                viewModel.retriveToken()
            }
            .alert("Incorrect Email or Password", isPresented:$isShowingIncorrecrAleart ){
                
            }
        }  
    
    }
}

#Preview {
    ContentView()
}
