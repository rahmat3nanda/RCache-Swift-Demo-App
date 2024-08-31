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
    
    @State var logs: [LogIdentifiableModel]? = nil
    
    var body: some View {
        ZStack {
            VStack(content: {
                if logs?.isEmpty ?? true {
                    Text("RCache")
                } else {
                    List {
                        ForEach(logs!.reversed()) { log in
                            Text("Date: \(log.time)\nAction: \(log.action)\nValue: \(log.value)")
                        }
                    }
                }
            })
            FloatingMenu(isMenuOpen: $isMenuOpen) {
                ItemMenuView(imageName: "trash", title: "Clear") {
                    isMenuOpen = false
                    router.navigate(to: .clear)
                }
                ItemMenuView(imageName: "square.and.arrow.up.trianglebadge.exclamationmark", title: "Remove") {
                    isMenuOpen = false
                    router.navigate(to: .remove)
                }
                ItemMenuView(imageName: "square.and.arrow.up.fill", title: "Read") {
                    isMenuOpen = false
                    router.navigate(to: .read)
                }
                ItemMenuView(imageName: "square.and.arrow.down.fill", title: "Save") {
                    isMenuOpen = false
                    router.navigate(to: .save)
                }
                ItemMenuView(imageName: "key.fill", title: "Key") {
                    isMenuOpen = false
                    router.navigate(to: .key)
                }
            }
        }
        .navigationBarTitle("RCache")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            logs = LogManager.instance.data()?.toIdentifible()
        })
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
