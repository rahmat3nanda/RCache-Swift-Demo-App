//
//  RemoveView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI

struct RemoveView: View {
    @StateObject private var removeViewModel = RemoveViewModel()
    @StateObject private var keyViewModel = KeyViewModel()
    
    @State private var selectedKey: KeyModel? = nil
    @State private var selectedStorageType: StorageType = .common
    
    @State private var buttonEnabled: Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack {
            FormHeaderView(
                key: $selectedKey,
                storageType: $selectedStorageType,
                showDataType: false,
                sourceDataType: DataType.allCases,
                sourceKey: keyViewModel.items,
                sourceStorageType: StorageType.allCases,
                dataTypeChanged: check,
                keyChanged: check,
                storageTypeChanged: check
            )
            
            Spacer()
            
            Button(action: submit) {
                HStack {
                    Spacer()
                    Text("Remove")
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
        .navigationTitle("RCache: Remove")
        .navigationBarTitleDisplayMode(.inline)
        .toastView(toast: $toast)
        .onAppear(perform: {
            keyViewModel.loadItems()
            selectedKey = keyViewModel.items.first
        })
    }
    
    func check() {
        buttonEnabled = selectedKey != nil
    }
    
    func submit() {
        removeViewModel.remove(key: selectedKey!, storageType: selectedStorageType)
        toast = Toast(style: .info, message: "Success remove variable with key \(selectedKey?.name ?? "") from \(selectedStorageType.rawValue)")
    }
}
