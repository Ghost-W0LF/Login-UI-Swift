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
    
    @EnvironmentObject var router: Router
    
    @State private var isNavigating = false
    @State private var isShowingSignout = false
    var email: String?
    var body: some View {
        VStack{
            
            
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
            .alert("Do want to sign out ?", isPresented: $isShowingSignout){
            
            Button("Signout"){
                router.navigateToRoot()
                viewModel.deleteValue()
                
            }.navigationDestination(isPresented:$isNavigating, destination: {
                ContentView()
            })
            .environmentObject(Router())
        }
        }.navigationBarBackButtonHidden(true)
            .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Signout") {
                                    isShowingSignout = true
                                }
                               
                            }
                        }
}
}
        
    
#Preview {
    Home()
    
}
