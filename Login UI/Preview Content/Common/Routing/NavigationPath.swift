//
//  NavigationPath.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/25/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case navigateLogin
        case navigateHome
    }
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
        debugPrint("Navigation t")
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
