//
//  HomeView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            VStack(content: {
                Text("RCache")
            })
            FloatingMenuView {
                Button(action: {
                    router.navigate(to: .key)
                }) {
                    VStack {
                        Image(systemName: "key.fill")
                            .frame(minWidth: 24)
                            .scaledToFill()
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        Text("Key")
                    }
                }
            }
        }
        .navigationBarTitle("RCache")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView()
}
