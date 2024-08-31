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
                cache(for: storageType).save(data: data, key: key.rCacheKey())
                completion(true, nil)
            } else {
                completion(false, "Data Invalid")
            }
        case .string:
            cache(for: storageType).save(string: value, key: key.rCacheKey())
        case .bool:
            if let bool = value.boolValue() {
                cache(for: storageType).save(bool: bool, key: key.rCacheKey())
                completion(true, nil)
            } else {
                completion(false, "Invalid Boolean")
            }
        case .integer:
            if let int = Int(value) {
                cache(for: storageType).save(integer: int, key: key.rCacheKey())
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
                cache(for: storageType).save(double: double, key: key.rCacheKey())
                completion(true, nil)
            } else {
                completion(false, "Invalid Double")
            }
        case .float:
            if let float = Float(value) {
                cache(for: storageType).save(float: float, key: key.rCacheKey())
                completion(true, nil)
            } else {
                completion(false, "Invalid Float")
            }
        }
    }
    
    func cache(for type: StorageType) -> RCaching {
        switch type {
        case .common: RCache.common
        case .credentials: RCache.credentials
        }
    }
}

fileprivate extension KeyModel {
    func rCacheKey() -> RCache.Key {
        return .init(name)
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
