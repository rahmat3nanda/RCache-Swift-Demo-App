//
//  FloatingMenuView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

struct FloatingMenuView<Content: View>: View {
    
    @State var isMenuOpen = false
    let content: Content
    
    init(isMenuOpen: Bool = false, @ViewBuilder content: () -> Content) {
        self.isMenuOpen = isMenuOpen
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if isMenuOpen {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }
            }
            
            VStack(alignment: .leading) {
                Spacer()
                
                if isMenuOpen {
                    HStack {
                        Spacer()
                        VStack {
                            content
                        }
                    }
                    .transition(.move(edge: .trailing))
                    .padding()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Image(systemName: isMenuOpen ? "xmark" : "line.3.horizontal")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    VStack {
        FloatingMenuView {
            ForEach(0..<3) { i in
                Text("Test \(i + 1)")}
        }
    }
}
