//
//  FormHeaderView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI

struct FormHeaderView: View {
    @Binding var dataType: DataType
    @Binding var key: KeyModel?
    @Binding var storageType: StorageType
    
    var sourceDataType: [DataType]
    var sourceKey: [KeyModel]
    var sourceStorageType: [StorageType]
    
    var dataTypeChanged: (() -> Void)? = nil
    var keyChanged: (() -> Void)? = nil
    var didKeyAdd: (() -> Void)? = nil
    var storageTypeChanged: (() -> Void)? = nil
    
    init(
        dataType: Binding<DataType>,
        key: Binding<KeyModel?> = .constant(nil),
        storageType: Binding<StorageType>,
        sourceDataType: [DataType],
        sourceKey: [KeyModel],
        sourceStorageType: [StorageType],
        dataTypeChanged: (() -> Void)? = nil,
        keyChanged: (() -> Void)? = nil,
        didKeyAdd: (() -> Void)? = nil,
        storageTypeChanged: (() -> Void)? = nil
    ) {
        self._dataType = dataType
        self._key = key
        self._storageType = storageType
        
        self.sourceDataType = sourceDataType
        self.sourceKey = sourceKey
        self.sourceStorageType = sourceStorageType
        
        self.dataTypeChanged = dataTypeChanged
        self.keyChanged = keyChanged
        self.didKeyAdd = didKeyAdd
        self.storageTypeChanged = storageTypeChanged
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Data Type:")
                Spacer()
                Picker("Data Type", selection: $dataType) {
                    ForEach(sourceDataType, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
            }
            .onChange(of: dataType) { _, __ in
                dataTypeChanged?()
            }
            
            HStack(spacing: 12) {
                Text("Key:")
                Spacer()
                Picker("Key", selection: $key) {
                    ForEach(sourceKey, id: \.id) { item in
                        Text(item.name).tag(item as KeyModel?)
                    }
                }
                Image(systemName: "plus")
                    .onTapGesture {
                        didKeyAdd?()
                    }
            }
            .onChange(of: key) { _, __ in
                keyChanged?()
            }
            
            HStack {
                Text("Storage Type:")
                Spacer()
                Picker("Storage Type", selection: $storageType) {
                    ForEach(sourceStorageType, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            .onChange(of: storageType) { _, __ in
                storageTypeChanged?()
            }
        }
    }
}

#Preview {
    @State var selectedDataType: DataType = .data
    @State var selectedStorageType: StorageType = .common
    return FormHeaderView(
        dataType: $selectedDataType,
        storageType: $selectedStorageType,
        sourceDataType: DataType.allCases,
        sourceKey: [],
        sourceStorageType: StorageType.allCases
    )
}
