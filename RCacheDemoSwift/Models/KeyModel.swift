//
//  KeyModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import Foundation
import RCache

struct KeyModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var rCacheKey: RCache.Key {
        return .init(name)
    }
}
