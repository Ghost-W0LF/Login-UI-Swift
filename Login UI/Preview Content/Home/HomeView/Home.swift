//
//  Home.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import SwiftUI



struct Home: View {
    @StateObject private var viewModel = ViewModel()
    @State var path = NavigationPath()
    @State private var isNavigating = false
    @State private var isShowingSignout = false
    var email: String?
    var body: some View {
        NavigationStack (){
            List {
                ForEach(viewModel.User, id: \.self) { item in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ChatView(userName:"\( item.id)")){
                            Text(item.title)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadData()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Signout") {
                        isShowingSignout = true
                    }
                    .navigationDestination(isPresented: $isNavigating) {
                        ContentView()
                    }
                }
            }
            .alert("Do want to sign out ?", isPresented: $isShowingSignout){
                Button("SignOut", role: .destructive){
                    viewModel.deleteValue()
                    isNavigating = true
                    
                }
                
            }
        }
    }
}

#Preview {
    Home()
}
