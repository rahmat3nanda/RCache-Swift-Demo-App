//
//  FloatingMenuView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

struct FloatingMenuView<Content: View>: View {
    
    @Binding var isMenuOpen: Bool
    let content: Content
    
    init(isMenuOpen: Binding<Bool> = .constant(false), @ViewBuilder content: () -> Content) {
        self._isMenuOpen = isMenuOpen
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if isMenuOpen {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
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
                        withAnimation(.easeInOut(duration: 0.2)) {
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
