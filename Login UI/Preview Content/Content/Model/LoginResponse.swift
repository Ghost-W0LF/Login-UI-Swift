//
//  LoginResponse.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/20/24.
//

import Foundation

struct LoginResponse: Decodable {
    let fullName: String
    let email: String
    let id: Int
    let token: String
    let isStaff: Bool
    // Use CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case id
        case token
        case isStaff = "is_staff"
    }
}

