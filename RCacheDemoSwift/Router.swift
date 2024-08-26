//
//  Router.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case addKey
        
        func view() -> some View {
            switch self {
            case .addKey:
                return TestView()
            }
        }
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
