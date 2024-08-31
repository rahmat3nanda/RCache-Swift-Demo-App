//
//  ReadViewModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI
import RCache

class ReadViewModel: ObservableObject {
    @Published var result: String = ""
    
    func load(key: KeyModel, storageType: StorageType, dataType: DataType) {
        switch dataType {
        case .data:
            let value = storageType.rCache.readData(key: key.rCacheKey)
            result = String(describing: String(data: value ?? "nil".data(using: .utf8) ?? Data(), encoding: .utf8) ?? "")
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .string:
            let value = storageType.rCache.readString(key: key.rCacheKey)
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .bool:
            let value = storageType.rCache.readBool(key: key.rCacheKey)
            result = "\(String(describing: value).uppercased())"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .integer:
            let value = storageType.rCache.readInteger(key: key.rCacheKey)
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .array:
            break
        case .dictionary:
            break
        case .double:
            let value = storageType.rCache.readDouble(key: key.rCacheKey)
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .float:
            let value = storageType.rCache.readFloat(key: key.rCacheKey)
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        }
    }
    
    private func addToLog(dataType: DataType, key: KeyModel, storageType: StorageType) {
        LogManager.instance.add(action: .read, value: "\n-Data Type: \(dataType.rawValue)\n-Key: \(key.name)\n-Storage Type: \(storageType.rawValue)\n-Value: \(result)")
    }
}
