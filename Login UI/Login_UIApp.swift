//
//  Login_UIApp.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/15/24.
//

import SwiftUI

@main
struct Login_UIApp: App {

    @ObservedObject private var router = Router()

    var body: some Scene {
        WindowGroup {
              NavigationStack(path: $router.navPath) {
                  ContentView()
                  .navigationDestination(for: Router.Destination.self) { destination in
                      switch destination {
                      case .navigateLogin:
                          ContentView()
                      case .navigateHome:
                          Home()
               
                         
                      }
                  }
              }
              .environmentObject(router)
          }

    }
}
