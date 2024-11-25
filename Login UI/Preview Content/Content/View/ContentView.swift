//
//  ContentView.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/15/24.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        @State  var navigate = viewModel.tokenData != ""
        @State  var isShowingIncorrecrAleart = viewModel.isShowingIncorectPassword
        VStack() {
            Form{
                Section{
                    TextField("Enter  your email",text:  $viewModel.email)
                    TextField("Enter your Password",text:  $viewModel.password)
   
                }
                Section{
                    Button(action:{
                        
                        Task {
                            await viewModel.loginRequest()
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            DispatchQueue.main.async {
                                if viewModel.tokenData.isEmpty {
                                    viewModel.isShowingIncorectPassword
                                    = true
                      
                                } else if !viewModel.tokenData.isEmpty  {
                                    router.navigate(to: .navigateHome)
                                }
                            }
                        }
                    }){
                        Text("Login")
                    }
                    
                }.disabled(viewModel.validation())
            }
            Button("Delete value pair for this email"){

            }
            Button("Update Password to  keychain"){
                viewModel.updatePassword()
            }.padding()
            Button("Get Password from keychain"){
                viewModel.retrivePassword()
            }
        }
        .onAppear{
            Task {
                viewModel.retriveToken()
                try? await Task.sleep(nanoseconds: 0_500_000_000)
                    if !viewModel.tokenData.isEmpty {
                        router.navigate(to: .navigateHome)
                    }
            }
        }
        .alert("Incorrect Email or Password", isPresented:$viewModel.isShowingIncorectPassword ){
            
        }
        
    }
}
#Preview {
    ContentView()
}
