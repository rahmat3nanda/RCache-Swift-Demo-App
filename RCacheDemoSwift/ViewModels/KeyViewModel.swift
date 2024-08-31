//
//  KeyViewModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import Foundation
import RCache

class KeyViewModel: ObservableObject {
    @Published var items: [KeyModel] = []
    
    func loadItems() {
        if let keys = RCache.common.readArray(key: .savedKeys) as? [String] {
            items = keys.map({ KeyModel(name: $0) })
        }
    }
    
    func append(_ item: KeyModel) {
        items.append(item)
        RCache.common.save(array: items.map({ $0.name }), key: .savedKeys)
        LogManager.instance.add(action: .add, input: .key, value: item.name)
    }
    
    func deleteItems(at offsets: IndexSet) {
        offsets.forEach { i in
            LogManager.instance.add(action: .remove, input: .key, value: items[i].name)
        }
        items.remove(atOffsets: offsets)
        RCache.common.save(array: items.map({ $0.name }), key: .savedKeys)
    }
}
