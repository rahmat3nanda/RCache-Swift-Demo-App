//
//  ReadView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI

struct ReadView: View {
    
    @StateObject private var readViewModel = ReadViewModel()
    @StateObject private var keyViewModel = KeyViewModel()
    
    @State private var selectedDataType: DataType = .data
    @State private var selectedKey: KeyModel? = nil
    @State private var selectedStorageType: StorageType = .common
    
    @State private var buttonEnabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            FormHeaderView(
                dataType: $selectedDataType,
                key: $selectedKey,
                storageType: $selectedStorageType,
                sourceDataType: DataType.allCases,
                sourceKey: keyViewModel.items,
                sourceStorageType: StorageType.allCases,
                dataTypeChanged: check,
                keyChanged: check,
                storageTypeChanged: check
            )
            
            Divider()
            
            if !readViewModel.result.isEmpty {
                Text("Result:\n\(readViewModel.result)")
            }
            
            Spacer()
            
            Button(action: submit) {
                HStack {
                    Spacer()
                    Text("Save")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.vertical)
            }
            .disabled(!buttonEnabled)
            .background(buttonEnabled ? .blue : .gray)
            .clipShape(.buttonBorder)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("RCache: Read")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            keyViewModel.loadItems()
            selectedKey = keyViewModel.items.first
        })
    }
    
    func check() {
        buttonEnabled = selectedKey != nil
    }
    
    func submit() {
        readViewModel.load(key: selectedKey!, storageType: selectedStorageType, dataType: selectedDataType)
    }
}
