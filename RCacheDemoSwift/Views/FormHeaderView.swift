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
    
    let showAddKey: Bool
    let showDataType: Bool
    
    var sourceDataType: [DataType]
    var sourceKey: [KeyModel]
    var sourceStorageType: [StorageType]
    
    var dataTypeChanged: (() -> Void)? = nil
    var keyChanged: (() -> Void)? = nil
    var didKeyAdd: (() -> Void)? = nil
    var storageTypeChanged: (() -> Void)? = nil
    
    init(
        dataType: Binding<DataType>? = nil,
        key: Binding<KeyModel?> = .constant(nil),
        storageType: Binding<StorageType>,
        showAddKey: Bool = false,
        showDataType: Bool = true,
        sourceDataType: [DataType],
        sourceKey: [KeyModel],
        sourceStorageType: [StorageType],
        dataTypeChanged: (() -> Void)? = nil,
        keyChanged: (() -> Void)? = nil,
        didKeyAdd: (() -> Void)? = nil,
        storageTypeChanged: (() -> Void)? = nil
    ) {
        @State var dummyDataType: DataType = .data
        self._dataType = dataType ?? $dummyDataType
        self._key = key
        self._storageType = storageType
        
        self.showAddKey = showAddKey
        self.showDataType = showDataType
        
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
            if showDataType {
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
            }
            
            HStack(spacing: 12) {
                Text("Key:")
                Spacer()
                Picker("Key", selection: $key) {
                    ForEach(sourceKey, id: \.id) { item in
                        Text(item.name).tag(item as KeyModel?)
                    }
                }
                
                if showAddKey {
                    Image(systemName: "plus")
                        .onTapGesture {
                            didKeyAdd?()
                        }
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
