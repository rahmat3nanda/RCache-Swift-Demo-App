//
//  SaveViewModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI
import RCache

class SaveViewModel: ObservableObject {
    func save(dataType: DataType, key: KeyModel, storageType: StorageType, value: String, completion: @escaping ((Bool, String?) -> Void)) {
        switch dataType {
        case .data:
            if let data = value.data(using: .utf8) {
                storageType.rCache.save(data: data, key: key.rCacheKey)
                addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
                completion(true, nil)
            } else {
                completion(false, "Data Invalid")
            }
        case .string:
            storageType.rCache.save(string: value, key: key.rCacheKey)
            completion(true, nil)
            addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
        case .bool:
            if let bool = value.boolValue() {
                storageType.rCache.save(bool: bool, key: key.rCacheKey)
                addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
                completion(true, nil)
            } else {
                completion(false, "Invalid Boolean")
            }
        case .integer:
            if let int = Int(value) {
                storageType.rCache.save(integer: int, key: key.rCacheKey)
                addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
                completion(true, nil)
            } else {
                completion(false, "Invalid Integer")
            }
        case .array:
             break
        case .dictionary:
            break
        case .double:
            if let double = Double(value) {
                storageType.rCache.save(double: double, key: key.rCacheKey)
                addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
                completion(true, nil)
            } else {
                completion(false, "Invalid Double")
            }
        case .float:
            if let float = Float(value) {
                storageType.rCache.save(float: float, key: key.rCacheKey)
                addToLog(dataType: dataType, key: key, storageType: storageType, value: value)
                completion(true, nil)
            } else {
                completion(false, "Invalid Float")
            }
        }
    }
    
    private func addToLog(dataType: DataType, key: KeyModel, storageType: StorageType, value: String) {
        LogManager.instance.add(action: .save, value: "\n-Data Type: \(dataType.rawValue)\n-Key: \(key.name)\n-Storage Type: \(storageType.rawValue)\n-Value: \(value)")
    }
}

fileprivate extension String {
    func boolValue() -> Bool? {
        if self.lowercased() == "true" {
            return true
        }
        if self.lowercased() == "false" {
            return false
        }
        return nil
    }
}
