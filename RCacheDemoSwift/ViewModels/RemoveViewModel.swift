//
//  RemoveViewModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI
import RCache

class RemoveViewModel: ObservableObject {
    func remove(key: KeyModel, storageType: StorageType) {
        storageType.rCache.remove(key: key.rCacheKey)
        LogManager.instance.add(action: .remove, value: "\n-Key: \(key.name)\n-Storage Type: \(storageType.rawValue))")
    }
}
