//
//  SaveView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 27/08/24.
//

import SwiftUI

struct SaveView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject private var saveViewModel = SaveViewModel()
    @StateObject private var keyViewModel = KeyViewModel()
    
    @State private var selectedDataType: DataType = .data
    @State private var selectedKey: KeyModel? = nil
    @State private var selectedStorageType: StorageType = .common
    
    @State private var fieldValue = ""
    
    @State private var buttonEnabled: Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            FormHeaderView(
                dataType: $selectedDataType,
                key: $selectedKey,
                storageType: $selectedStorageType,
                showAddKey: true,
                sourceDataType: DataType.allCases,
                sourceKey: keyViewModel.items,
                sourceStorageType: StorageType.allCases,
                dataTypeChanged: {
                    fieldValue = ""
                    hideKeyboard()
                    check()
                },
                keyChanged: check,
                didKeyAdd: {
                    router.navigate(to: .key)
                },
                storageTypeChanged: check
            )
            
            Divider()
            
            Text("Value:")
            
            
            if selectedDataType == .bool {
                RadioButtonGroup(items: ["TRUE", "FALSE"]) { value in
                    fieldValue = value
                    check()
                }
            }
            
            if selectedDataType.isUseTextField {
                TextField("Value", text: $fieldValue)
                    .keyboardType(selectedDataType.isNumber ? .decimalPad : .default)
                    .onChange(of: fieldValue, check)
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
        .navigationTitle("RCache: Save")
        .navigationBarTitleDisplayMode(.inline)
        .toastView(toast: $toast)
        .onAppear(perform: {
            keyViewModel.loadItems()
            selectedKey = keyViewModel.items.first
        })
    }
    
    func check() {
        buttonEnabled = !fieldValue.isEmpty && selectedKey != nil
    }
    
    func submit() {
        saveViewModel.save(dataType: selectedDataType, key: selectedKey!, storageType: selectedStorageType, value: fieldValue) { (success, message) in
            if success {
                toast = Toast(style: .success, message: "Success Saving")
                fieldValue = ""
            } else {
                toast = Toast(style: .error, message: message ?? "Unknown Error")
            }
        }
    }
}

#Preview {
    SaveView()
}

#if canImport(UIKit)
extension SaveView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
