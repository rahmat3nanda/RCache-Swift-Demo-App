//
//  RCacheDemoApp.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

@main
struct RCacheDemoApp: App {
    
    @ObservedObject var router = Router()
    @StateObject var keyViewModel = KeyViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        destination.view()
                    }
            }
            .environmentObject(router)
            .environmentObject(keyViewModel)
        }
    }
}
