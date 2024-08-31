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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .key: KeyView()
                        case .save: SaveView()
                        case .read: ReadView()
                        case .remove: RemoveView()
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
