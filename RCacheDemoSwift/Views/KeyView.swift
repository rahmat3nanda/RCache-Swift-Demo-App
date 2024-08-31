//
//  KeyView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import SwiftUI

struct KeyView: View {
    
    @StateObject private var viewModel = KeyViewModel()
    @State private var showAlert = false
    @State private var key: String = ""
    
    var body: some View {
        ZStack {
            if viewModel.items.isEmpty {
                Text("Empty")
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        Text(item.name)
                    }
                    .onDelete(perform: viewModel.deleteItems)
                }
            }
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName:  "plus")
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
        .navigationTitle("RCache: Key")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Add Key", isPresented: $showAlert, actions: {
            TextField("Key", text: $key)
            
            Button("Cancel", role: .cancel) {
                key = ""
                showAlert = false
            }
            Button("Save") {
                showAlert = false
                viewModel.append(KeyModel(name: key))
                key = ""
            }
        })
        .onAppear(perform: {
            viewModel.loadItems()
        })
    }
}

#Preview {
    KeyView()
}
