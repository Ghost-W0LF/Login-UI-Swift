//
//  HomeViewModel.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import Foundation
extension  Home{
    class ViewModel{
        @Published var navigate = false
        @Published var Users:[user] = [
            .init(Name: "User 1", Email: "USer1@gmail.com", Image: "Audiobook Sticker"),
            .init(Name: "User 2", Email: "USer1@gmail.com", Image: "image"),
            .init(Name: "User 3", Email: "USer1@gmail.com", Image: "Audiobook Sticker"),
            .init(Name: "User 4", Email: "USer1@gmail.com", Image: "image"),
        ]
    }
}
struct user : Hashable {
    var Name: String
    var Email: String
    var Image: String
    
    
}
