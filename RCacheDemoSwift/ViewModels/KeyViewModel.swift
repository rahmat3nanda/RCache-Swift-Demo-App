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
    }
    
    func append(contentsOf: [KeyModel]) {
        items.append(contentsOf: contentsOf)
    }
    
    func setItems(_ data: [KeyModel]) {
        items = data
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
