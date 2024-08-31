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
            let value = cache(for: storageType).readData(key: key.rCacheKey())
            result = String(describing: String(data: value ?? "nil".data(using: .utf8) ?? Data(), encoding: .utf8) ?? "")
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .string:
            let value = cache(for: storageType).readString(key: key.rCacheKey())
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .bool:
            let value = cache(for: storageType).readBool(key: key.rCacheKey())
            result = "\(String(describing: value).uppercased())"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .integer:
            let value = cache(for: storageType).readInteger(key: key.rCacheKey())
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .array:
            break
        case .dictionary:
            break
        case .double:
            let value = cache(for: storageType).readDouble(key: key.rCacheKey())
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        case .float:
            let value = cache(for: storageType).readFloat(key: key.rCacheKey())
            result = "\(String(describing: value))"
            addToLog(dataType: dataType, key: key, storageType: storageType)
        }
    }
    
    private func cache(for type: StorageType) -> RCaching {
        switch type {
        case .common: RCache.common
        case .credentials: RCache.credentials
        }
    }
    
    private func addToLog(dataType: DataType, key: KeyModel, storageType: StorageType) {
        LogManager.instance.add(action: .read, value: "\n-Data Type: \(dataType.rawValue)\n-Key: \(key.name)\n-Storage Type: \(storageType.rawValue)\n-Value: \(result)")
    }
}

fileprivate extension KeyModel {
    func rCacheKey() -> RCache.Key {
        return .init(name)
    }
}
