//
//  Home.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import SwiftUI

struct Home: View {
  var email: String?
    var body: some View {
        @State  var viewModel = ViewModel()
        NavigationStack{
            VStack{
                List(viewModel.Users,id:\.self){ item in
                    NavigationLink(destination: ChatView( userName:item.Name)) {
                        Text("\(item.Email)").padding()
                        
                    }
                }
                
            }
        }
    }
}

#Preview {
    Home()
}
