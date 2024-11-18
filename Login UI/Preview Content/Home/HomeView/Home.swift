//
//  Home.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import SwiftUI


struct Home: View {
    @StateObject private var viewModel = ViewModel()
    var email: String?
    var body: some View {
        NavigationStack{
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
                
            }
        }
    }
}

#Preview {
    Home()
}
