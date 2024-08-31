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
    @State private var selectedSaveType: StorageType = .common
    
    @State private var fieldValue = ""
    
    @State private var buttonEnabled: Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Data Type:")
                Spacer()
                Picker("Data Type", selection: $selectedDataType) {
                    ForEach(DataType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
            }
            .onChange(of: selectedDataType) {
                fieldValue = ""
                hideKeyboard()
                check()
            }
            
            HStack(spacing: 12) {
                Text("Key:")
                Spacer()
                Picker("Key", selection: $selectedKey) {
                    ForEach(keyViewModel.items, id: \.id) { item in
                        Text(item.name).tag(item as KeyModel?)
                    }
                }
                Image(systemName: "plus").onTapGesture {
                    router.navigate(to: .key)
                }
            }
            .onChange(of: selectedKey, check)
            
            HStack {
                Text("Storage Type:")
                Spacer()
                Picker("Storage Type", selection: $selectedSaveType) {
                    ForEach(StorageType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            .onChange(of: selectedSaveType, check)
            
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
                    .keyboardType(selectedDataType.isNumber ? .numberPad : .default)
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
        saveViewModel.save(dataType: selectedDataType, key: selectedKey!, storageType: selectedSaveType, value: fieldValue) { (success, message) in
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
