//
//  ChatView.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import SwiftUI

struct ChatView: View {
    @State  var viewModel = ViewModel()
    var userName: String?
    var body: some View {

        NavigationStack{
            Text("Hi")
            .navigationTitle("\(userName ?? "NoName" )  ")
        }
    }
}

#Preview {
    ChatView()
}
