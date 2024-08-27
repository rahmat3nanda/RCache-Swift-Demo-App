//
//  HomeView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    @State var isMenuOpen = false
    
    var body: some View {
        ZStack {
            VStack(content: {
                Text("RCache")
            })
            FloatingMenuView(isMenuOpen: $isMenuOpen) {
                ItemMenuView(imageName: "key.fill", title: "Key") {
                    isMenuOpen = false
                    router.navigate(to: .key)
                }
            }
        }
        .navigationBarTitle("RCache")
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct ItemMenuView: View {
    let imageName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .frame(minWidth: 24)
                    .scaledToFill()
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                VStack {
                    Text(title)
                        .tint(.white)
                        .padding(
                            .init(
                                top: 4,
                                leading: 12,
                                bottom: 4,
                                trailing: 12
                            )
                        ).frame(minWidth: 36)
                }
                .background(.blue)
                .clipShape(.rect(cornerRadius: 6))
            }
        }
    }
}

#Preview {
    HomeView()
}
